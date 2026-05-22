Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA067360EC0
	for <kvm@vger.kernel.org>; Fri, 22 May 2026 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470142; cv=none; b=pl63LNfT9kVvzk0CjqXIqg8UKUTL085pesDCqrxz4c5/EWjfMe8jGiS0EVUNJgJfHNTZ/9jSFkBDVT/uHVc8dXRqDWv0ixq+Rl2HzFZ4TtyIeacXoAMW0VwEBX4PF/FQZsVy4ai3cpu4JserMWyOU5/2n+ij++jGeVxgAud9zpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470142; c=relaxed/simple;
	bh=e5dyY8YqRqEPKI0nAbjYOFkB0DKyfX93SO1m/kNHFx8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gcasjsQ4YtIZhWEtVVfTH6faDkeQxAy+Sad//Yo9VggN7eq9gCFhtX7OKOt+jpCFqRy3kg1J0v9BswpWp93Ye96RNrHFzt2CoFSGokyfxcdXriiOAahfNswzHgLqX+SqBN3lkNgT+E/0YrVUTUaMW1/n1JvKR4q+D6NHHxNF7KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vp89xAib; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vp89xAib"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c8510f91ce8so1407523a12.2
        for <kvm@vger.kernel.org>; Fri, 22 May 2026 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779470140; x=1780074940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=YtCRiPb6Iavp2sFC8pmBGncPk6YakRaW7R43mFkUN8o=;
        b=vp89xAibGhZAquJePq+ZrxS5olItGF0w8WdjHIoXuqb76QtY4p3DOZNp/WSRIJcvJl
         n5yYrIAXuChdRKGgncUDTiRVoVEPdCAAQHMZe73L2ExFab4+zMa8sqO5twWZ+545DqAX
         SciEK1/lY3aysC2pyn4LWEfm0pZVd5BrbhYVjIF1a4K0lgnIztXT3FfuHROo8xWbI+G7
         eXp5i1aKycqQB8GxplMLmBkzzn7KWKUuZakQwWArOp9YX+DO23WDNnEEdWFNAhgW7CyN
         0WjTUCxbVhNNL8lQfmyFEoAi21Db0zST4SQhvG6FHr+aNlDd7F5NCxCHtBRofpmOpObA
         Y9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779470140; x=1780074940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtCRiPb6Iavp2sFC8pmBGncPk6YakRaW7R43mFkUN8o=;
        b=hhxf/NiYbG4Mrgxv+hWbd6ArnRs8h8SAgrCNnoBP6RDJNKu6l6ndLi4yrfdOUawpko
         o6h/IOosEJfkTQXimclGim9m6G6e8J0Ptjl/kX/4O5AFMNrRsIRpEutcNhI3101u6iIz
         AbG7E6vtbPz4U1+we+OUaMLwE3PA5KTCxGM6JMBy1BmepjfP4XuaiIC19kqauDMKvIZk
         D6T04TivNtflPE3LDRFFJ2RbZMYkOMQNm5I2ttInZEEaXB/yr8VDgQmGSLndlrkMUwmY
         0be1rLExrRqNalX7YwE8v7Gy0iU7FhOnhbnkHrqcuRFnY1NCR30J9WWwWBVlcPzmrrxJ
         /9nQ==
X-Gm-Message-State: AOJu0Yx5C1/KFsjw++3/XYhWnEuv31/+HOTfohD5RUOyCt9IQqy0LbHi
	cN0/8wEXN7IsuZWT2G+cATv2Lm4n7c+nPx0RSYcDnu/KPYvcHqArkUDKhMoGkXLI35xM2C8mEQb
	SGgsOJQ==
X-Received: from pfbbk23.prod.google.com ([2002:aa7:8317:0:b0:82f:4abd:a354])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4fc1:b0:82c:9126:320c
 with SMTP id d2e1a72fcca58-8415f0e6355mr4747837b3a.3.1779470139880; Fri, 22
 May 2026 10:15:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 22 May 2026 10:15:35 -0700
In-Reply-To: <20260522171535.3525890-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260522171535.3525890-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.794.g4f17f83d09-goog
Message-ID: <20260522171535.3525890-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: selftests: Add and use kvm_free_fd() to harden
 against fd goofs
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bibo Mao <maobibo@loongson.cn>, 
	Sean Christopherson <seanjc@google.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a kvm_free_fd() macro to close and invalidate a file descriptor, and
use it through the core infrastructure to harden against goofs where a
selftest attempts to reuse a closed file descriptor.

Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Fuad Tabba <tabba@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_syscalls.h      |  6 +++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 23 +++++++++----------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index 067a4c9cf452..6cb3bed29b81 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -89,4 +89,10 @@ __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, l
 __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
 __KVM_SYSCALL_DEFINE(madvise, 3, void *, addr, size_t, length, int, advice);
 
+#define kvm_free_fd(fd)		\
+do {				\
+	kvm_close(fd);		\
+	(fd) = -1;		\
+} while (0)
+
 #endif /* SELFTEST_KVM_SYSCALLS_H */
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 4ad015c6c44f..195f3fdae1e3 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -77,7 +77,8 @@ static ssize_t get_module_param(const char *module_name, const char *param,
 	int fd, r;
 
 	/* Verify KVM is loaded, to provide a more helpful SKIP message. */
-	close(open_kvm_dev_path_or_exit());
+	fd = open_kvm_dev_path_or_exit();
+	kvm_free_fd(fd);
 
 	r = snprintf(path, path_size, "/sys/module/%s/parameters/%s",
 		     module_name, param);
@@ -90,8 +91,7 @@ static ssize_t get_module_param(const char *module_name, const char *param,
 	TEST_ASSERT(bytes_read > 0, "read(%s) returned %ld, wanted %ld bytes",
 		    path, bytes_read, buffer_size);
 
-	r = close(fd);
-	TEST_ASSERT(!r, "close(%s) failed", path);
+	kvm_free_fd(fd);
 	return bytes_read;
 }
 
@@ -160,7 +160,7 @@ unsigned int kvm_check_cap(long cap)
 	ret = __kvm_ioctl(kvm_fd, KVM_CHECK_EXTENSION, (void *)cap);
 	TEST_ASSERT(ret >= 0, KVM_IOCTL_ERROR(KVM_CHECK_EXTENSION, ret));
 
-	close(kvm_fd);
+	kvm_free_fd(kvm_fd);
 
 	return (unsigned int)ret;
 }
@@ -747,8 +747,7 @@ static void kvm_stats_release(struct kvm_binary_stats *stats)
 		stats->desc = NULL;
 	}
 
-	kvm_close(stats->fd);
-	stats->fd = -1;
+	kvm_free_fd(stats->fd);
 }
 
 __weak void vcpu_arch_free(struct kvm_vcpu *vcpu)
@@ -777,7 +776,7 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 
 	kvm_munmap(vcpu->run, vcpu_mmap_sz());
 
-	kvm_close(vcpu->fd);
+	kvm_free_fd(vcpu->fd);
 	kvm_stats_release(&vcpu->stats);
 
 	list_del(&vcpu->list);
@@ -793,8 +792,8 @@ void kvm_vm_release(struct kvm_vm *vmp)
 	list_for_each_entry_safe(vcpu, tmp, &vmp->vcpus, list)
 		vm_vcpu_rm(vmp, vcpu);
 
-	kvm_close(vmp->fd);
-	kvm_close(vmp->kvm_fd);
+	kvm_free_fd(vmp->fd);
+	kvm_free_fd(vmp->kvm_fd);
 
 	/* Free cached stats metadata and close FD */
 	kvm_stats_release(&vmp->stats);
@@ -815,10 +814,10 @@ static void __vm_mem_region_delete(struct kvm_vm *vm,
 	if (region->fd >= 0) {
 		/* There's an extra map when using shared memory. */
 		kvm_munmap(region->mmap_alias, region->mmap_size);
-		close(region->fd);
+		kvm_free_fd(region->fd);
 	}
 	if ((int)region->region.guest_memfd >= 0)
-		close(region->region.guest_memfd);
+		kvm_free_fd(region->region.guest_memfd);
 
 	free(region);
 }
@@ -1311,7 +1310,7 @@ static size_t vcpu_mmap_sz(void)
 	TEST_ASSERT(ret >= 0 && ret >= sizeof(struct kvm_run),
 		    KVM_IOCTL_ERROR(KVM_GET_VCPU_MMAP_SIZE, ret));
 
-	close(dev_fd);
+	kvm_free_fd(dev_fd);
 
 	return ret;
 }
-- 
2.54.0.794.g4f17f83d09-goog

