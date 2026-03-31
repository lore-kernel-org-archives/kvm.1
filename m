Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD43C872F
	for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774986108; cv=none; b=dIsdXD8yfgrU1HsxWHuTZ8/xEuxfEgEjnSjEifCLRvVmAVYxcF8tSqYmi6wdtFP8UaaqW3LYn4NoDwAozXeYhQ9do6vKhmDN3zIFbcg2ircUFVU5UGSSwyjPqR+npIVa3YntALwCfjvxHBFD1aaz/QZlfy7LdQyL80toJIGZk+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774986108; c=relaxed/simple;
	bh=8nlZJJakPYKxthOlYtGkU5lDHCbh/o0QhTMAKpigJYQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VHWCfWoVRgU+ILRl/KuSMJreRH87ZIeXUa2cG0Wv6N2SorZfGEZY+Hm0bsTEGOaZ62jE6AV2BgGQKFVR8QwLpHdbw+KPmoj6Aw3cS+JJY0L8ZoWMNVrsgtJrD0H9qlhBoRS/gA6drmD5JXTbAkEALCP37snHacmdWcigQh/1QdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wdJsg9/x; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrhilke.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wdJsg9/x"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82c9364612fso10000397b3a.2
        for <kvm@vger.kernel.org>; Tue, 31 Mar 2026 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774986106; x=1775590906; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=L43TS7wakZgv0JVn64yQAQLb3nHZ0zi1bzL9o8oFHlc=;
        b=wdJsg9/xGkW512PNNxgioHamkLTVFcgV9QMlHNSMmm/70cBCRBqj4UQ2411gHM+31t
         X19XT+crBsG3D26FsqP35HsmXgbVSnSSWlQh84eB/0Cx8ws/tlachb8dQOHArSik0BNI
         wuJfIp4EXFjSsV961gjlpvIH9+2eZA6wEM1yU1tgGVPfN8FXtlPMZCBA7qCFfkRkuRrz
         kJhmdjDl3Jj7d85ry8xI+gnUmuBnlG7OFB2CP4ZrEBwTGpTLvdTUo5uhS8HfVZTx/HU8
         h5A4qXmk/2i4khQJbbCk9H6bVT+NSV12giFRIhcmkh0sJNd7156TwPpfbc+my1p2P0Vi
         o4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774986106; x=1775590906;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L43TS7wakZgv0JVn64yQAQLb3nHZ0zi1bzL9o8oFHlc=;
        b=e28ZFk+2867CI1p1+DJHR02dX9sqdN5ObAx7C3DB2s47CVNDYJKhUrenQD3ll6FMjw
         x/REhDMOq+kJbSsLFLp0O8vm8vY/tijZXnnRIEb+UjcgWdPLsflTHXIZriTwnOo0+OX9
         RYnXFbZttZYhLwtqUfCmtLrB9TvZnVgrYT9rDFSIPEEOcew4hk60xAMVrsfC6sJydyLQ
         TeVw9WaNPLfQkVagKcZpQYFF6OWEmxzAMqjSbUFLDenxzJhnh4LmE1lhEFR6n7L3p0vk
         JKsQfZkLEh2oFfMtKE1xiS6nNr7DxMlXt7lxwGDUuIr2YSnWXw1Tm8KV5iJvn/vc1mkp
         QqUA==
X-Gm-Message-State: AOJu0YxAVWlbMCq8CAwz6/hX4B8llhXsieHF/kLHuCUCkGmIUsWKtZDA
	vUpjwLvDyISMdCyc7EUtvRdpkEwfmD0g5vcndxr6q109S6jW/Oq5Cr9N+Wn6B2dFbPuKqiqM35P
	utBItCUZd
X-Received: from pfbly3.prod.google.com ([2002:a05:6a00:7583:b0:824:9ab3:ebe8])
 (user=jrhilke job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:b87:b0:81f:5037:a317
 with SMTP id d2e1a72fcca58-82ce88d321amr860080b3a.11.1774986106190; Tue, 31
 Mar 2026 12:41:46 -0700 (PDT)
Date: Tue, 31 Mar 2026 19:40:30 +0000
In-Reply-To: <20260331194033.3890309-1-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260331194033.3890309-1-jrhilke@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260331194033.3890309-12-jrhilke@google.com>
Subject: [PATCH v2 11/14] KVM: selftests: Add support for vCPU pinning
From: Josh Hilke <jrhilke@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Josh Hilke <jrhilke@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Matlack <dmatlack@google.com>

Add the '-p' flag to vfio_pci_irq_test to pin vCPU threads to random
physical CPUs throughout the test. This stresses the interaction between
vCPU migration and interrupt delivery, ensuring that interrupts find
their target even as the vCPU moves across the host's pCPUs.

Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Josh Hilke <jrhilke@google.com>
Co-developed-by: Josh Hilke <jrhilke@google.com>
---
 .../selftests/kvm/include/kvm_syscalls.h      |  7 ++
 .../testing/selftests/kvm/vfio_pci_irq_test.c | 79 ++++++++++++++++++-
 2 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_syscalls.h b/tools/testing/selftests/kvm/include/kvm_syscalls.h
index d4e613162bba..5f839f735640 100644
--- a/tools/testing/selftests/kvm/include/kvm_syscalls.h
+++ b/tools/testing/selftests/kvm/include/kvm_syscalls.h
@@ -73,9 +73,16 @@ static inline int kvm_dup(int fd)
 	return new_fd;
 }
 
+static inline int gettid(void)
+{
+	return syscall(__NR_gettid);
+}
+
 __KVM_SYSCALL_DEFINE(munmap, 2, void *, mem, size_t, size);
 __KVM_SYSCALL_DEFINE(close, 1, int, fd);
 __KVM_SYSCALL_DEFINE(fallocate, 4, int, fd, int, mode, loff_t, offset, loff_t, len);
 __KVM_SYSCALL_DEFINE(ftruncate, 2, unsigned int, fd, off_t, length);
+__KVM_SYSCALL_DEFINE(sched_setaffinity, 3, pid_t, pid, size_t, cpusetsize, const cpu_set_t *, mask);
+__KVM_SYSCALL_DEFINE(sched_getaffinity, 3, pid_t, pid, size_t, cpusetsize, cpu_set_t *, mask);
 
 #endif /* SELFTEST_KVM_SYSCALLS_H */
diff --git a/tools/testing/selftests/kvm/vfio_pci_irq_test.c b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
index fa77ce348251..c2f48c6710dd 100644
--- a/tools/testing/selftests/kvm/vfio_pci_irq_test.c
+++ b/tools/testing/selftests/kvm/vfio_pci_irq_test.c
@@ -22,6 +22,8 @@ static bool guest_ready_for_irqs[KVM_MAX_VCPUS];
 static bool guest_received_irq[KVM_MAX_VCPUS];
 static bool guest_received_nmi[KVM_MAX_VCPUS];
 
+static pid_t vcpu_tids[KVM_MAX_VCPUS];
+
 #define TIMEOUT_NS (2ULL * 1000 * 1000 * 1000)
 
 static u32 guest_get_vcpu_id(void)
@@ -64,12 +66,64 @@ static void *vcpu_thread_main(void *arg)
 	struct kvm_vcpu *vcpu = arg;
 	struct ucall uc;
 
+	WRITE_ONCE(vcpu_tids[vcpu->id], syscall(__NR_gettid));
+
 	vcpu_run(vcpu);
 	TEST_ASSERT_EQ(UCALL_DONE, get_ucall(vcpu, &uc));
 
 	return NULL;
 }
 
+static int get_cpu(struct kvm_vcpu *vcpu)
+{
+	pid_t tid = vcpu_tids[vcpu->id];
+	cpu_set_t cpus;
+	int cpu = -1;
+	int i;
+
+	kvm_sched_getaffinity(tid, sizeof(cpus), &cpus);
+
+	for (i = 0; i < get_nprocs(); i++) {
+		if (!CPU_ISSET(i, &cpus))
+			continue;
+
+		if (cpu != -1) {
+			cpu = i;
+		} else {
+			/* vCPU is pinned to multiple CPUs */
+			return -1;
+		}
+	}
+
+	return cpu;
+}
+
+static void pin_vcpu_threads(int nr_vcpus, int start_cpu, cpu_set_t *available_cpus)
+{
+	const size_t size = sizeof(cpu_set_t);
+	int nr_cpus, cpu, vcpu_index = 0;
+	cpu_set_t target_cpu;
+
+	nr_cpus = get_nprocs();
+	CPU_ZERO(&target_cpu);
+
+	for (cpu = start_cpu;; cpu = (cpu + 1) % nr_cpus) {
+		if (vcpu_index == nr_vcpus)
+			break;
+
+		if (!CPU_ISSET(cpu, available_cpus))
+			continue;
+
+		CPU_SET(cpu, &target_cpu);
+
+		kvm_sched_setaffinity(vcpu_tids[vcpu_index], size, &target_cpu);
+
+		CPU_CLR(cpu, &target_cpu);
+
+		vcpu_index++;
+	}
+}
+
 static void kvm_clear_gsi_routes(struct kvm_vm *vm)
 {
 	struct kvm_irq_routing routes = {};
@@ -132,7 +186,7 @@ static void send_msi(struct vfio_pci_device *device, bool use_device_msi, int ms
 
 static void help(const char *name)
 {
-	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] segment:bus:device.function\n",
+	printf("Usage: %s [-a] [-b] [-d] [-e] [-h] [-i nr_irqs] [-n] [-p] segment:bus:device.function\n",
 	       name);
 	printf("\n");
 	printf("  -a: Randomly affinitize the device IRQ to different CPUs\n"
@@ -145,6 +199,7 @@ static void help(const char *name)
 	printf("  -i: The number of IRQs to generate during the test.\n");
 	printf("  -n: Route some of the device interrupts to be delivered as\n"
 	       "      an NMI into the guest.\n");
+	printf("  -p: Pin vCPU threads to random pCPUs throughout the test.\n");
 	printf("\n");
 	exit(KSFT_FAIL);
 }
@@ -167,7 +222,7 @@ int main(int argc, char **argv)
 	u8 vector = 32 + rand() % (UINT8_MAX - 32);
 
 	/* Test configuration (overridable by command line flags). */
-	bool use_device_msi = false, irq_affinity = false;
+	bool use_device_msi = false, irq_affinity = false, pin_vcpus = false;
 	bool empty = false, nmi = false;
 	int nr_irqs = 1000;
 	int nr_vcpus = 1;
@@ -177,6 +232,7 @@ int main(int argc, char **argv)
 	u64 irq_count, pin_count, piw_count;
 	struct vfio_pci_device *device;
 	struct iommu *iommu;
+	cpu_set_t available_cpus;
 	const char *device_bdf;
 	FILE *irq_affinity_fp;
 	int i, j, c, msi, irq;
@@ -186,7 +242,7 @@ int main(int argc, char **argv)
 
 	device_bdf = vfio_selftests_get_bdf(&argc, argv);
 
-	while ((c = getopt(argc, argv, "abdehi:n")) != -1) {
+	while ((c = getopt(argc, argv, "abdehi:np")) != -1) {
 		switch (c) {
 		case 'a':
 			irq_affinity = true;
@@ -206,6 +262,9 @@ int main(int argc, char **argv)
 		case 'n':
 			nmi = true;
 			break;
+		case 'p':
+			pin_vcpus = true;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -243,6 +302,15 @@ int main(int argc, char **argv)
 			continue;
 	}
 
+	if (pin_vcpus) {
+		kvm_sched_getaffinity(vcpu_tids[0], sizeof(available_cpus), &available_cpus);
+
+		if (nr_vcpus > CPU_COUNT(&available_cpus)) {
+			printf("There are more vCPUs than pCPUs; refusing to pin.\n");
+			pin_vcpus = false;
+		}
+	}
+
 	if (irq_affinity) {
 		char path[PATH_MAX];
 
@@ -272,6 +340,9 @@ int main(int argc, char **argv)
 			TEST_ASSERT(ret > 0, "Failed to affinitize IRQ-%d to CPU %d", irq, irq_cpu);
 		}
 
+		if (pin_vcpus && vcpu->id == 0)
+			pin_vcpu_threads(nr_vcpus, rand() % get_nprocs(), &available_cpus);
+
 		for (j = 0; j < nr_vcpus; j++) {
 			TEST_ASSERT(
 				!READ_FROM_GUEST(vm, guest_received_irq[vcpu->id]),
@@ -300,6 +371,8 @@ int main(int argc, char **argv)
 				printf("  do_empty: %d\n", do_empty);
 				if (irq_affinity)
 					printf("  irq_cpu: %d\n", irq_cpu);
+				if (pin_vcpus)
+					printf("  vcpu_cpu: %d\n", get_cpu(vcpu));
 
 				TEST_FAIL("vCPU never received IRQ!\n");
 			}
-- 
2.53.0.1118.gaef5881109-goog

