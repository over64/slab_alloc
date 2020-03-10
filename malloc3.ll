; ModuleID = 'malloc3.c'
source_filename = "malloc3.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Entry = type { i64, i64, i64, i64, i64, i64, i8*, %struct.slab*, %struct.slab*, %struct.slab* }
%struct.slab = type { i64, [64 x i64], [4096 x i64], [262144 x i64], [16777216 x %struct.obj], %struct.slab* }
%struct.obj = type { i32, i32, i64 }
%struct.sclass_t = type { i32, i32 }

@.str = private unnamed_addr constant [23 x i8] c"slab size(bytes): %ld\0A\00", align 1
@entry = dso_local thread_local global %struct.Entry zeroinitializer, align 8
@.str.1 = private unnamed_addr constant [21 x i8] c"data start(0) = %ld\0A\00", align 1
@.str.3 = private unnamed_addr constant [37 x i8] c"l1bit=%ld idx2=%ld idx3=%ld idx4=%ld\00", align 1
@classes = dso_local local_unnamed_addr global [2 x %struct.sclass_t] [%struct.sclass_t { i32 -16, i32 -262145 }, %struct.sclass_t { i32 -32, i32 -262145 }], align 16
@.str.4 = private unnamed_addr constant [13 x i8] c"ffs(0) = %d\0A\00", align 1
@.str.5 = private unnamed_addr constant [13 x i8] c"ffs(1) = %d\0A\00", align 1
@.str.6 = private unnamed_addr constant [16 x i8] c"ffs(4096) = %d\0A\00", align 1
@.str.7 = private unnamed_addr constant [32 x i8] c"16777216 * 10^3 iterations done\00", align 1
@str = private unnamed_addr constant [14 x i8] c"out of memory\00", align 1

; Function Attrs: nofree nounwind uwtable
define dso_local void @my_init() local_unnamed_addr #0 {
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i64 270565904)
  %2 = tail call noalias i8* @calloc(i64 270565904, i64 1) #9
  %3 = getelementptr inbounds i8, i8* %2, i64 2130440
  store i8* %3, i8** getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 6), align 8, !tbaa !2
  call void @llvm.memset.p0i8.i64(i8* align 8 bitcast (%struct.slab** getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 7) to i8*), i8 0, i64 24, i1 false)
  %4 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1, i64 0, i64 0), i8** getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 6))
  ret void
}

; Function Attrs: nofree nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: nofree nounwind
declare dso_local noalias i8* @calloc(i64, i64) local_unnamed_addr #1

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local void @reindex3(%struct.slab* nocapture, i64) local_unnamed_addr #2 {
  ret void
}

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local void @reindex2(%struct.slab* nocapture, i64, i64) local_unnamed_addr #2 {
  ret void
}

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local void @reindex1(%struct.slab* nocapture, i64, i64, i64) local_unnamed_addr #2 {
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local nonnull i8* @my_malloc(i64) local_unnamed_addr #3 {
  %2 = load i8*, i8** getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 6), align 8, !tbaa !2
  %3 = getelementptr i8, i8* %2, i64 -2097152
  %4 = bitcast i8* %3 to i64*
  %5 = load i64, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 0), align 8, !tbaa !8
  %6 = getelementptr inbounds i64, i64* %4, i64 %5
  %7 = load i64, i64* %6, align 8, !tbaa !9
  %8 = icmp eq i64 %7, -1
  br i1 %8, label %9, label %19, !prof !10

9:                                                ; preds = %1
  %10 = load i64, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 3), align 8, !tbaa !11
  %11 = getelementptr inbounds i8, i8* %2, i64 -2129920
  %12 = bitcast i8* %11 to i64*
  %13 = getelementptr inbounds i8, i8* %2, i64 -2130432
  %14 = bitcast i8* %13 to i64*
  %15 = getelementptr inbounds i8, i8* %2, i64 -2130440
  %16 = bitcast i8* %15 to i64*
  br label %35

17:                                               ; preds = %64
  %18 = getelementptr inbounds i64, i64* %4, i64 %68
  br label %19

19:                                               ; preds = %17, %1
  %20 = phi i64 [ %5, %1 ], [ %68, %17 ]
  %21 = phi i64* [ %6, %1 ], [ %18, %17 ]
  %22 = phi i64 [ %7, %1 ], [ %70, %17 ]
  %23 = xor i64 %22, -1
  %24 = tail call i64 @llvm.cttz.i64(i64 %23, i1 true), !range !12
  %25 = bitcast i8* %2 to %struct.obj*
  %26 = shl i64 1, %24
  %27 = or i64 %26, %22
  store i64 %27, i64* %21, align 8, !tbaa !9
  %28 = shl i64 %20, 6
  %29 = or i64 %24, %28
  %30 = trunc i64 %29 to i32
  %31 = getelementptr inbounds %struct.obj, %struct.obj* %25, i64 %29, i32 1
  store i32 %30, i32* %31, align 4, !tbaa !13
  %32 = getelementptr inbounds %struct.obj, %struct.obj* %25, i64 %29, i32 0
  store i32 0, i32* %32, align 8, !tbaa !16
  %33 = getelementptr inbounds %struct.obj, %struct.obj* %25, i64 %29, i32 2
  %34 = bitcast i64* %33 to i8*
  ret i8* %34

35:                                               ; preds = %9, %64
  %36 = phi i64 [ %10, %9 ], [ %65, %64 ]
  %37 = load i64, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 1), align 8, !tbaa !17
  %38 = shl i64 1, %36
  %39 = getelementptr inbounds i64, i64* %12, i64 %37
  %40 = load i64, i64* %39, align 8, !tbaa !9
  %41 = or i64 %40, %38
  store i64 %41, i64* %39, align 8, !tbaa !9
  %42 = icmp eq i64 %41, -1
  br i1 %42, label %46, label %43, !prof !10

43:                                               ; preds = %35
  %44 = xor i64 %41, -1
  %45 = tail call i64 @llvm.cttz.i64(i64 %44, i1 true), !range !12
  br label %64

46:                                               ; preds = %35
  %47 = load i64, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 2), align 8, !tbaa !18
  %48 = load i64, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 4), align 8, !tbaa !19
  %49 = shl i64 1, %48
  %50 = getelementptr inbounds i64, i64* %14, i64 %47
  %51 = load i64, i64* %50, align 8, !tbaa !9
  %52 = or i64 %51, %49
  store i64 %52, i64* %50, align 8, !tbaa !9
  %53 = icmp eq i64 %52, -1
  br i1 %53, label %72, label %54, !prof !10

54:                                               ; preds = %46
  %55 = xor i64 %52, -1
  %56 = tail call i64 @llvm.cttz.i64(i64 %55, i1 true), !range !12
  store i64 %56, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 4), align 8, !tbaa !19
  %57 = shl i64 %47, 6
  %58 = or i64 %56, %57
  store i64 %58, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 1), align 8, !tbaa !17
  %59 = getelementptr inbounds i64, i64* %12, i64 %58
  %60 = load i64, i64* %59, align 8, !tbaa !9
  %61 = xor i64 %60, -1
  %62 = tail call i64 @llvm.cttz.i64(i64 %61, i1 true), !range !12
  %63 = icmp ne i64 %60, -1
  tail call void @llvm.assume(i1 %63)
  br label %64

64:                                               ; preds = %54, %78, %43
  %65 = phi i64 [ %62, %54 ], [ %91, %78 ], [ %45, %43 ]
  %66 = phi i64 [ %58, %54 ], [ %87, %78 ], [ %37, %43 ]
  store i64 %65, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 3), align 8, !tbaa !11
  %67 = shl i64 %66, 6
  %68 = or i64 %65, %67
  store i64 %68, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 0), align 8, !tbaa !8
  %69 = getelementptr inbounds i64, i64* %4, i64 %68
  %70 = load i64, i64* %69, align 8, !tbaa !9
  %71 = icmp eq i64 %70, -1
  br i1 %71, label %35, label %17, !prof !10

72:                                               ; preds = %46
  %73 = load i64, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 5), align 8, !tbaa !20
  %74 = shl i64 1, %73
  %75 = load i64, i64* %16, align 8, !tbaa !9
  %76 = or i64 %75, %74
  store i64 %76, i64* %16, align 8, !tbaa !9
  %77 = icmp eq i64 %76, -1
  br i1 %77, label %93, label %78, !prof !10

78:                                               ; preds = %72
  %79 = xor i64 %76, -1
  %80 = tail call i64 @llvm.cttz.i64(i64 %79, i1 true), !range !12
  store i64 %80, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 5), align 8, !tbaa !20
  store i64 %80, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 2), align 8, !tbaa !18
  %81 = getelementptr inbounds i64, i64* %14, i64 %80
  %82 = load i64, i64* %81, align 8, !tbaa !9
  %83 = xor i64 %82, -1
  %84 = tail call i64 @llvm.cttz.i64(i64 %83, i1 true), !range !12
  %85 = icmp ne i64 %82, -1
  tail call void @llvm.assume(i1 %85)
  store i64 %84, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 4), align 8, !tbaa !19
  %86 = shl nuw nsw i64 %80, 6
  %87 = or i64 %84, %86
  store i64 %87, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 1), align 8, !tbaa !17
  %88 = getelementptr inbounds i64, i64* %12, i64 %87
  %89 = load i64, i64* %88, align 8, !tbaa !9
  %90 = xor i64 %89, -1
  %91 = tail call i64 @llvm.cttz.i64(i64 %90, i1 true), !range !12
  %92 = icmp ne i64 %89, -1
  tail call void @llvm.assume(i1 %92)
  br label %64

93:                                               ; preds = %72
  %94 = tail call i32 @puts(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @str, i64 0, i64 0))
  %95 = load i64, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 5), align 8, !tbaa !20
  %96 = load i64, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 2), align 8, !tbaa !18
  %97 = load i64, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 1), align 8, !tbaa !17
  %98 = load i64, i64* getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 0), align 8, !tbaa !8
  %99 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.3, i64 0, i64 0), i64 %95, i64 %96, i64 %97, i64 %98)
  tail call void @exit(i32 1) #12
  unreachable
}

; Function Attrs: nounwind readnone speculatable
declare i64 @llvm.cttz.i64(i64, i1 immarg) #4

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) local_unnamed_addr #5

; Function Attrs: alwaysinline nofree norecurse nounwind uwtable
define dso_local void @free_storage_class(i8* nocapture, i32, i64, i64) local_unnamed_addr #6 {
  %5 = zext i32 %1 to i64
  %6 = mul nsw i64 %5, %2
  %7 = getelementptr inbounds i8, i8* %0, i64 %6
  %8 = bitcast i8* %7 to i64*
  %9 = getelementptr inbounds i64, i64* %8, i64 %3
  %10 = and i32 %1, 63
  %11 = zext i32 %10 to i64
  %12 = lshr i32 %1, 6
  %13 = zext i32 %12 to i64
  %14 = getelementptr inbounds i64, i64* %9, i64 %13
  %15 = load i64, i64* %14, align 8, !tbaa !9
  %16 = shl i64 1, %11
  %17 = xor i64 %16, -1
  %18 = and i64 %15, %17
  store i64 %18, i64* %14, align 8, !tbaa !9
  %19 = icmp eq i64 %18, 0
  br i1 %19, label %20, label %53, !prof !10

20:                                               ; preds = %4
  %21 = sdiv i64 %3, 64
  %22 = getelementptr inbounds i64, i64* %9, i64 %21
  %23 = and i32 %12, 63
  %24 = zext i32 %23 to i64
  %25 = lshr i32 %1, 12
  %26 = zext i32 %25 to i64
  %27 = getelementptr inbounds i64, i64* %22, i64 %26
  %28 = load i64, i64* %27, align 8, !tbaa !9
  %29 = shl i64 1, %24
  %30 = xor i64 %29, -1
  %31 = and i64 %28, %30
  store i64 %31, i64* %27, align 8, !tbaa !9
  %32 = icmp eq i64 %31, 0
  br i1 %32, label %33, label %53, !prof !10

33:                                               ; preds = %20
  %34 = sdiv i64 %3, 4096
  %35 = getelementptr inbounds i64, i64* %22, i64 %34
  %36 = and i32 %25, 63
  %37 = zext i32 %36 to i64
  %38 = lshr i32 %1, 18
  %39 = zext i32 %38 to i64
  %40 = getelementptr inbounds i64, i64* %35, i64 %39
  %41 = load i64, i64* %40, align 8, !tbaa !9
  %42 = shl i64 1, %37
  %43 = xor i64 %42, -1
  %44 = and i64 %41, %43
  store i64 %44, i64* %40, align 8, !tbaa !9
  %45 = icmp eq i64 %44, 0
  br i1 %45, label %46, label %53, !prof !10

46:                                               ; preds = %33
  %47 = sdiv i64 %3, 262144
  %48 = getelementptr inbounds i64, i64* %35, i64 %47
  %49 = shl i64 1, %39
  %50 = xor i64 %49, -1
  %51 = load i64, i64* %48, align 8, !tbaa !9
  %52 = and i64 %51, %50
  store i64 %52, i64* %48, align 8, !tbaa !9
  br label %53

53:                                               ; preds = %20, %46, %33, %4
  ret void
}

; Function Attrs: nofree noinline norecurse nounwind uwtable
define dso_local void @my_free(i8* nocapture) local_unnamed_addr #7 {
  %2 = getelementptr inbounds i8, i8* %0, i64 -8
  %3 = getelementptr inbounds i8, i8* %0, i64 -4
  %4 = bitcast i8* %3 to i32*
  %5 = load i32, i32* %4, align 4, !tbaa !13
  %6 = bitcast i8* %2 to i32*
  %7 = load i32, i32* %6, align 8, !tbaa !16
  %8 = zext i32 %7 to i64
  %9 = getelementptr inbounds [2 x %struct.sclass_t], [2 x %struct.sclass_t]* @classes, i64 0, i64 %8, i32 0
  %10 = load i32, i32* %9, align 8
  %11 = getelementptr inbounds [2 x %struct.sclass_t], [2 x %struct.sclass_t]* @classes, i64 0, i64 %8, i32 1
  %12 = load i32, i32* %11, align 4
  %13 = sext i32 %10 to i64
  %14 = sext i32 %12 to i64
  %15 = zext i32 %5 to i64
  %16 = mul nsw i64 %13, %15
  %17 = getelementptr inbounds i8, i8* %0, i64 %16
  %18 = bitcast i8* %17 to i64*
  %19 = getelementptr inbounds i64, i64* %18, i64 %14
  %20 = and i32 %5, 63
  %21 = zext i32 %20 to i64
  %22 = lshr i32 %5, 6
  %23 = zext i32 %22 to i64
  %24 = getelementptr inbounds i64, i64* %19, i64 %23
  %25 = load i64, i64* %24, align 8, !tbaa !9
  %26 = shl i64 1, %21
  %27 = xor i64 %26, -1
  %28 = and i64 %25, %27
  store i64 %28, i64* %24, align 8, !tbaa !9
  %29 = icmp eq i64 %28, 0
  br i1 %29, label %30, label %63, !prof !10

30:                                               ; preds = %1
  %31 = sdiv i64 %14, 64
  %32 = getelementptr inbounds i64, i64* %19, i64 %31
  %33 = and i32 %22, 63
  %34 = zext i32 %33 to i64
  %35 = lshr i32 %5, 12
  %36 = zext i32 %35 to i64
  %37 = getelementptr inbounds i64, i64* %32, i64 %36
  %38 = load i64, i64* %37, align 8, !tbaa !9
  %39 = shl i64 1, %34
  %40 = xor i64 %39, -1
  %41 = and i64 %38, %40
  store i64 %41, i64* %37, align 8, !tbaa !9
  %42 = icmp eq i64 %41, 0
  br i1 %42, label %43, label %63, !prof !10

43:                                               ; preds = %30
  %44 = sdiv i64 %14, 4096
  %45 = getelementptr inbounds i64, i64* %32, i64 %44
  %46 = and i32 %35, 63
  %47 = zext i32 %46 to i64
  %48 = lshr i32 %5, 18
  %49 = zext i32 %48 to i64
  %50 = getelementptr inbounds i64, i64* %45, i64 %49
  %51 = load i64, i64* %50, align 8, !tbaa !9
  %52 = shl i64 1, %47
  %53 = xor i64 %52, -1
  %54 = and i64 %51, %53
  store i64 %54, i64* %50, align 8, !tbaa !9
  %55 = icmp eq i64 %54, 0
  br i1 %55, label %56, label %63, !prof !10

56:                                               ; preds = %43
  %57 = sdiv i64 %14, 262144
  %58 = getelementptr inbounds i64, i64* %45, i64 %57
  %59 = shl i64 1, %49
  %60 = xor i64 %59, -1
  %61 = load i64, i64* %58, align 8, !tbaa !9
  %62 = and i64 %61, %60
  store i64 %62, i64* %58, align 8, !tbaa !9
  br label %63

63:                                               ; preds = %1, %30, %43, %56
  ret void
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #8 {
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i64 0, i64 0), i32 0)
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.5, i64 0, i64 0), i32 0)
  %3 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i64 0, i64 0), i32 12)
  %4 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i64 270565904) #9
  %5 = tail call noalias i8* @calloc(i64 270565904, i64 1) #9
  %6 = getelementptr inbounds i8, i8* %5, i64 2130440
  store i8* %6, i8** getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 6), align 8, !tbaa !2
  tail call void @llvm.memset.p0i8.i64(i8* align 8 bitcast (%struct.slab** getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 7) to i8*), i8 0, i64 24, i1 false) #9
  %7 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.1, i64 0, i64 0), i8** getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 6)) #9
  br label %8

8:                                                ; preds = %15, %0
  %9 = phi i64 [ 0, %0 ], [ %16, %15 ]
  br label %10

10:                                               ; preds = %10, %8
  %11 = phi i32 [ 0, %8 ], [ %13, %10 ]
  %12 = tail call i8* @my_malloc(i64 16)
  %13 = add nuw nsw i32 %11, 1
  %14 = icmp eq i32 %13, 16777216
  br i1 %14, label %18, label %10

15:                                               ; preds = %18
  %16 = add nuw nsw i64 %9, 1
  %17 = icmp eq i64 %16, 1000
  br i1 %17, label %25, label %8

18:                                               ; preds = %10, %18
  %19 = phi i64 [ %23, %18 ], [ 16777215, %10 ]
  %20 = load %struct.obj*, %struct.obj** bitcast (i8** getelementptr inbounds (%struct.Entry, %struct.Entry* @entry, i64 0, i32 6) to %struct.obj**), align 8, !tbaa !2
  %21 = getelementptr inbounds %struct.obj, %struct.obj* %20, i64 %19, i32 2
  %22 = bitcast i64* %21 to i8*
  tail call void @my_free(i8* nonnull %22)
  %23 = add nsw i64 %19, -1
  %24 = icmp eq i64 %19, 0
  br i1 %24, label %15, label %18

25:                                               ; preds = %15
  %26 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.7, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i64 @inv(i64) local_unnamed_addr #2 {
  %2 = xor i64 %0, -1
  ret i64 %2
}

; Function Attrs: nounwind
declare void @llvm.assume(i1) #9

; Function Attrs: nofree nounwind
declare i32 @puts(i8* nocapture readonly) local_unnamed_addr #10

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #11

attributes #0 = { nofree nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-enqcmd,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-enqcmd,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { norecurse nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-enqcmd,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-enqcmd,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone speculatable }
attributes #5 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-enqcmd,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { alwaysinline nofree norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-enqcmd,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nofree noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-enqcmd,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="skylake" "target-features"="+64bit,+adx,+aes,+avx,+avx2,+bmi,+bmi2,+clflushopt,+cmov,+cx16,+cx8,+f16c,+fma,+fsgsbase,+fxsr,+invpcid,+lzcnt,+mmx,+movbe,+mpx,+pclmul,+popcnt,+prfchw,+rdrnd,+rdseed,+rtm,+sahf,+sgx,+sse,+sse2,+sse3,+sse4.1,+sse4.2,+ssse3,+x87,+xsave,+xsavec,+xsaveopt,+xsaves,-avx512bf16,-avx512bitalg,-avx512bw,-avx512cd,-avx512dq,-avx512er,-avx512f,-avx512ifma,-avx512pf,-avx512vbmi,-avx512vbmi2,-avx512vl,-avx512vnni,-avx512vp2intersect,-avx512vpopcntdq,-cldemote,-clwb,-clzero,-enqcmd,-fma4,-gfni,-lwp,-movdir64b,-movdiri,-mwaitx,-pconfig,-pku,-prefetchwt1,-ptwrite,-rdpid,-sha,-shstk,-sse4a,-tbm,-vaes,-vpclmulqdq,-waitpkg,-wbnoinvd,-xop" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { nounwind }
attributes #10 = { nofree nounwind }
attributes #11 = { argmemonly nounwind }
attributes #12 = { noreturn nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 9.0.1-8 "}
!2 = !{!3, !7, i64 48}
!3 = !{!"", !4, i64 0, !4, i64 8, !4, i64 16, !4, i64 24, !4, i64 32, !4, i64 40, !7, i64 48, !7, i64 56, !7, i64 64, !7, i64 72}
!4 = !{!"long", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{!"any pointer", !5, i64 0}
!8 = !{!3, !4, i64 0}
!9 = !{!4, !4, i64 0}
!10 = !{!"branch_weights", i32 1, i32 2000}
!11 = !{!3, !4, i64 24}
!12 = !{i64 0, i64 65}
!13 = !{!14, !15, i64 4}
!14 = !{!"", !15, i64 0, !15, i64 4, !4, i64 8}
!15 = !{!"int", !5, i64 0}
!16 = !{!14, !15, i64 0}
!17 = !{!3, !4, i64 8}
!18 = !{!3, !4, i64 16}
!19 = !{!3, !4, i64 32}
!20 = !{!3, !4, i64 40}
