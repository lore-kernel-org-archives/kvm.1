Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D183FD14F
	for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391425; cv=none; b=rTeWnvaXYQZpnbqPcbFf+cnf6YWAa2uMpUxpklFjIJq4ohyJF37CfxZn0kRG25Ud9XdV4axVJNoXVKs6RdhaoqmQDlO2hsNOY86BXeBBb9p2id+Dewub32Dx2GqVsjJ6CbDpDWN2co1y2ruZF4QM9JagFxnmDfFm9HiBKY/ScKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391425; c=relaxed/simple;
	bh=vNdbm/0Obc4fuKtBvfdsROOb1B8uqbT+2nOWFswh3xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8UyJgIAWcBEbl5hPvWzaHINpFToZrhgvqId5GXL5WDZnXHc6wdNdhKJJBW4eiCvpsBuOrXlkKfYxERQpEktc3erwzzwNdC92qoxQM6TJnwJwi2GbIt51TyoMx+TDYoxVo6321CdmRazkFpb9DBxhrDveDwm1/SCMWiBIai0t7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPew9Mzj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kCmq4bdL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPew9Mzj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kCmq4bdL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789391422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oAtEKro1IwTIfB00hgsxl2ApCEESr6GF0Gn4Vo+1cR4=;
	b=DPew9MzjHjT1zKWYbY+oq3oFoq23q4+OSUQxJPLJ6UQwHWYG5E2wP0UJVhOAvBDeN9NRno
	FYJ3AWauC8tz6Jzx/ZjWAqazqtg8j+vH98Uxyx0cpuDNjpcr+mpOHs2IihtTBNGqsXGyzP
	EZkziRfTHRDM5jykccYEdTU92jzXX2U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-2dB1G7Z7OWaz_umDm_-lgQ-1; Mon, 14 Sep 2026 09:10:21 -0400
X-MC-Unique: 2dB1G7Z7OWaz_umDm_-lgQ-1
X-Mimecast-MFC-AGG-ID: 2dB1G7Z7OWaz_umDm_-lgQ_1789391420
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e65bee41aso21933565e9.0
        for <kvm@vger.kernel.org>; Mon, 14 Sep 2026 06:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789391420; x=1789996220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oAtEKro1IwTIfB00hgsxl2ApCEESr6GF0Gn4Vo+1cR4=;
        b=kCmq4bdLe5NLewQN6O4dwJtLBZhhnuIvbsbqSgHgWtmLyticG8MDcKYIsSimmCa2m3
         s1Pm/efESg99pVrmnKEL3hzJrlHJKfOw7YG1LWcD8JL31DopYaxpHxR8YXa6Ixy9gWqu
         CSyg0T4X7/+HfXSa3VpVkG80I5/QK8M4xs//JKhsUo0TCJ8KR4kCqNf5InuoS5QQv5Ra
         3cqv0q1SPgr4RXsMxvPjLnERZUEX/LAHVszfYl5wnAlqO6DiTR69XeO1lj+4TWw+WAZT
         LsB4nhP5SpaUuZkHtlej+jE4gaOI5suYSoIWlQw57gI7VgVP4b8YPpkHRZxEdRS3FLfR
         m4dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391420; x=1789996220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oAtEKro1IwTIfB00hgsxl2ApCEESr6GF0Gn4Vo+1cR4=;
        b=ZmeD78qoVy7FMOgL2A9khVSU34++zRgN8Lp1rL8t6ZKK0hKm/UHRVY0Im9nPp7noAK
         br0c1rXXZel2V+cx604BfGc5r4WTXeAXzzxC7248O/Ul0ioDqO4SVgwPtR8SN+9RkLko
         MVb9Ruvjl29r9e6LSF9FOGYWGOqHKzgLKvEd8+dMrcUS2/BQxwSt9Ig2Qk0C/yJL+PWC
         83eTjyvjZQJll62Uw7XcNxN8tmsI7HnO3qCvvaO5vXWHCaxnc7PtgZ7KGVzLIxVFa8xY
         j0FPG4muFT+PP6jXOOJI5act0rI9xYL+l2IJ/Z8L11HYBw4VfHgz9lPkWlRytzc0op75
         qk3A==
X-Forwarded-Encrypted: i=1; AKwUvBzBjEqCtgFcsBMF9qVO/e0ALB5bo+TFzg3euQdCDQbCPMJubCceqlDYNv+39j2CeXydJyI=@vger.kernel.org
X-Gm-Message-State: AFuF++mHscBREFQ8IOlkf+eJciLXpZIXIHZSft7hfm9ZeVX88G3u7H9N
	oifw46mQ7OXYy1FcKX3fMEmozGJ/EKlQ0OAmEsb1zy1uv6ZulgIxS+mbD043Hvgg383b7aKaQdG
	t9JmFDbREaSPOccpaG3O2Aic5yMBP5uUjEHXJhGFAL2he8qWYRN2M9A==
X-Gm-Gg: AYBFou2ImQb+hNoOCIImQwXfMoPsz+8d0N1z+x8zPF09rElnuB+Fp7jswXEJo0ggnty
	hK08hFc67kklu4RgEm0l/xzrWodm7GdvTKpZEjofpWw9mA/S3WoU6YIG4NQU22+DYwJtYKEZ+aK
	XAKlR7MRWz5MM9ds5hVmAZmWdsjkf8+03VshsIzBg+bW7uqWu1kgUJ7mx1D/tv9tgOZFcptxfjJ
	psIOcDVCyNwpH7dZ4quW6Q/PQwUtuZJfahVLjh/dMND2p1FJrXmVV/aDim+VzIjnGY9ITUfZitd
	LRUBMYrTbFTz3lUXN8ubFOP7FZZx1g+VTpvRSUXB5nHeWf7z2nPQwQlc4edF9/UzjNAps1dBsIo
	iWzPaNcjgXT9xlVCbNmZ2eqC8Plk6LJLwovPAAxLfsC7eUS/HzrGknBzau8b57WASgA==
X-Received: by 2002:a05:600c:3e1b:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49e7a5fb97emr32989655e9.0.1789391419788;
        Mon, 14 Sep 2026 06:10:19 -0700 (PDT)
X-Received: by 2002:a05:600c:3e1b:b0:49e:6836:5386 with SMTP id 5b1f17b1804b1-49e7a5fb97emr32988925e9.0.1789391419239;
        Mon, 14 Sep 2026 06:10:19 -0700 (PDT)
Received: from rh.redhat.corp (p200300f6af1c8300fec44a2b8bbb173f.dip0.t-ipconnect.de. [2003:f6:af1c:8300:fec4:4a2b:8bbb:173f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e71e300f3sm222248655e9.7.2026.09.14.06.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:10:18 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Zenghui Yu <zenghui.yu@linux.dev>
Cc: Jiakai Xu <xujiakai2025@iscas.ac.cn>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Anup Patel <anup@brainfault.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kvmarm@lists.linux.dev,
	Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v2] KVM: selftests: fix steal_time for arm64 with host page size > 4K
Date: Mon, 14 Sep 2026 15:10:13 +0200
Message-ID: <20260914131013.60334-1-sebott@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following failure when running with 16K host page size:
==== Test Assertion Failure ====
  lib/kvm_util.c:991: vm_adjust_num_guest_pages(vm->mode, npages) == npages
  pid=873 tid=873 errno=0 - Success
     1  0x0000000000405a27: vm_mem_add at kvm_util.c:991
     2  0x000000000040241f: check_steal_time_uapi at steal_time.c:223 (discriminator 7)
     3   (inlined by) main at steal_time.c:539 (discriminator 7)
     4  0x00007fff8b57af3b: ?? ??:0
     5  0x00007fff8b57b007: ?? ??:0
     6  0x0000000000402b6f: _start at ??:?
  Number of guest pages is not compatible with the host. Try npages=4

Fixes: fc240715fc50 ("KVM: selftests: arm64: Fix steal_time test after UAPI refactoring")
Reported-by: Zenghui Yu <zenghui.yu@linux.dev>
Link: https://lore.kernel.org/kvmarm/7575a845-a542-4b16-b512-aec3126f97f3@linux.dev/T/#u
Signed-off-by: Sebastian Ott <sebott@redhat.com>
---
 tools/testing/selftests/kvm/steal_time.c | 30 ++++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index bc3c62b72c58..785d19f9ee8f 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -27,6 +27,9 @@
 static void *st_gva[NR_VCPUS];
 static u64 guest_stolen_time[NR_VCPUS];
 
+static struct kvm_vm *vm_create_steal_time(u32 nr_vcpus, void *guest_code,
+					   struct kvm_vcpu *vcpus[]);
+
 #if defined(__x86_64__)
 
 /* steal_time must have 64-byte alignment */
@@ -210,17 +213,14 @@ static void check_steal_time_uapi(void)
 	u64 st_ipa;
 	int ret;
 
-	vm = vm_create_with_one_vcpu(&vcpu, NULL);
-
 	struct kvm_device_attr dev = {
 		.group = KVM_ARM_VCPU_PVTIME_CTRL,
 		.attr = KVM_ARM_VCPU_PVTIME_IPA,
 		.addr = (u64)&st_ipa,
 	};
 
+	vm = vm_create_steal_time(1, NULL, &vcpu);
 	vcpu_ioctl(vcpu, KVM_HAS_DEVICE_ATTR, &dev);
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, 1, 0);
-	virt_map(vm, ST_GPA_BASE, ST_GPA_BASE, 1);
 
 	st_ipa = (ulong)ST_GPA_BASE | 1;
 	ret = __vcpu_ioctl(vcpu, KVM_SET_DEVICE_ATTR, &dev);
@@ -500,13 +500,27 @@ static void run_vcpu(struct kvm_vcpu *vcpu)
 	}
 }
 
+static struct kvm_vm *vm_create_steal_time(u32 nr_vcpus, void *guest_code,
+					   struct kvm_vcpu *vcpus[])
+{
+	unsigned int gpages;
+	struct kvm_vm *vm;
+
+	/* Create a VM and an identity mapped memslot for the steal time structure */
+	vm = vm_create_with_vcpus(nr_vcpus, guest_code, vcpus);
+	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, STEAL_TIME_SIZE * nr_vcpus);
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, gpages, 0);
+	virt_map(vm, ST_GPA_BASE, ST_GPA_BASE, gpages);
+
+	return vm;
+}
+
 int main(int ac, char **av)
 {
 	struct kvm_vcpu *vcpus[NR_VCPUS];
 	struct kvm_vm *vm;
 	pthread_t thread;
 	cpu_set_t cpuset;
-	unsigned int gpages;
 	long stolen_time;
 	long run_delay;
 	bool verbose;
@@ -517,11 +531,7 @@ int main(int ac, char **av)
 	/* Set CPU affinity so we can force preemption of the VCPU */
 	cpu = pin_self_to_any_cpu();
 
-	/* Create a VM and an identity mapped memslot for the steal time structure */
-	vm = vm_create_with_vcpus(NR_VCPUS, guest_code, vcpus);
-	gpages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, STEAL_TIME_SIZE * NR_VCPUS);
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, ST_GPA_BASE, 1, gpages, 0);
-	virt_map(vm, ST_GPA_BASE, ST_GPA_BASE, gpages);
+	vm = vm_create_steal_time(NR_VCPUS, guest_code, vcpus);
 
 	ksft_print_header();
 	TEST_REQUIRE(is_steal_time_supported(vcpus[0]));
-- 
2.55.0

