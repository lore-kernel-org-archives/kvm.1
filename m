Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC2A372B4B;
	Mon, 11 May 2026 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499042; cv=none; b=LrHRbKt86M49na7RffcrbQpUOboQ2TB6aJUm1ZqcF/1aWp7CrJTMaAa108h6sh8ygYyVThI4bgvdxA4G4LitczbORuMkpv31MyjuvIZGzBMIAC8iTYFQh1GY2DdHS9QrW7twYjnYJUXu+xMtZIXTRJLh5icoZju0xkyuGjmRjXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499042; c=relaxed/simple;
	bh=2mtvTqgUhCWUW3dIVoWO8/tqIfoGtA9AP55Jy4CxLP4=;
	h=Message-Id:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=WuaebIpJOUwLdx7e/gQ5/G0EWLN+4bjemjFuFQglF5uvZf3jvfytcmxRDEi+sB9LZnxzkaqc1H++xSzk1ivb3N1CZlDaDkW8wQCPJh4PlJ3pi+k1DtImwIBElBN/bWvWg/kir6Vt17QRz3hn7KbpLJTON4m0TQSFiaosZ5wwhX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn; spf=pass smtp.mailfrom=sanechips.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sanechips.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sanechips.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gDcwY06Ymz57DCl;
	Mon, 11 May 2026 19:30:37 +0800 (CST)
Received: (from root@localhost)
	by mse-fl2.zte.com.cn id 64BBUXDN013040;
	Mon, 11 May 2026 19:30:33 +0800 (+08)
	(envelope-from wu.fei9@sanechips.com.cn)
Message-Id: <202605111130.64BBUXDN013040@mse-fl2.zte.com.cn>
Received: from njy2app01.zte.com.cn ([10.40.12.136])
	by mse-fl2.zte.com.cn with SMTP id 64BBNLsu005557;
	Mon, 11 May 2026 19:23:21 +0800 (+08)
	(envelope-from wu.fei9@sanechips.com.cn)
Received: from mapi (njb2app07[null])
	by mapi (Zmail) with MAPI id mid204;
	Mon, 11 May 2026 19:23:23 +0800 (CST)
X-Zmail-TransId: 2aff6a01bc2bf89-94e41
X-Mailer: Zmail v1.0
In-Reply-To: <202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn>
References: 202605111849442561v1a0B_7W1L2Z-ENusLaP@zte.com.cn
Date: Mon, 11 May 2026 19:23:23 +0800 (CST)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <wu.fei9@sanechips.com.cn>
To: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
        <kvm-riscv@lists.infradead.org>
Cc: <anup@brainfault.org>, <atish.patra@linux.dev>, <pjw@kernel.org>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
        <pbonzini@redhat.com>, <shuah@kernel.org>, <wu.fei9@sanechips.com.cn>
Subject: =?UTF-8?B?W1BBVENIIDEvM10gS1ZNOiBzZWxmdGVzdHM6IEFkZCB1bml0IHRvIGRpcnR5X2xvZ190ZXN0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 64BBUXDN013040
X-MSS: AUDITRELEASE@mse-fl2.zte.com.cn
X-TLS: YES
X-SPF-DOMAIN: sanechips.com.cn
X-ENVELOPE-SENDER: wu.fei9@sanechips.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Mon, 11 May 2026 19:30:37 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A01BDDD.000/4gDcwY06Ymz57DCl

Currently dirty_log_test hardcodes usleep 1ms in each interval, which
could be too short for guest to write and fault in enough pages, then
there is less chance to test the write protection mechanism, especially
in the case of (log_mode != LOG_MODE_DIRTY_RING).

Unit is introduced to replace the default 1ms if specified in command
line. The following test can't trigger failure on my riscv vm:

  # ./dirty_log_test -m 21 -M clear-log

By enlarging unit, it fails every time:

  # ./dirty_log_test -u 100 -m 21 -M clear-log
  Random seed: 0x6b8b4567
  Setting log mode to: 'clear-log'
  Test iterations: 32, interval: 10, unit: 100 (ms)
  Testing guest mode: PA-bits:50,  VA-bits:48,  4K pages
  guest physical test memory offset: 0x3ffffbfffc000
  Iteration  1: dirty: 262147 clean: 0      writes: 8454
  ==== Test Assertion Failure ====
    dirty_log_test.c:565: val < iteration
    pid=295 tid=295 errno=0 - Success
  sh: addr2line: not found
    Clear page 197160 value (2) >= iteration (2) (last = 18446744073709551615, prev_last = 18446744073709551615)

Signed-off-by: Wu Fei <wu.fei9@sanechips.com.cn>
---
 tools/testing/selftests/kvm/dirty_log_test.c | 24 ++++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
index 12446a4b6e8d..06234a77f1c5 100644
--- a/tools/testing/selftests/kvm/dirty_log_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_test.c
@@ -34,9 +34,12 @@
 /* How many host loops to run (one KVM_GET_DIRTY_LOG for each loop) */
 #define TEST_HOST_LOOP_N               32UL

-/* Interval for each host loop (ms) */
+/* Interval for each host loop (number of units) */
 #define TEST_HOST_LOOP_INTERVAL                10UL

+/* ms per unit, one iteration takes (interval * unit) ms */
+#define TEST_HOST_LOOP_UNIT            1UL
+
 /*
  * Ensure the vCPU is able to perform a reasonable number of writes in each
  * iteration to provide a lower bound on coverage.
@@ -592,6 +595,7 @@ static struct kvm_vm *create_vm(enum vm_guest_mode mode, struct kvm_vcpu **vcpu,
 struct test_params {
        unsigned long iterations;
        unsigned long interval;
+       unsigned long unit;
        u64 phys_offset;
 };

@@ -718,7 +722,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
                         * and so that the test doesn't run too far beyond the
                         * specified interval.
                         */
-                       usleep(1000);
+                       usleep(1000 * p->unit);

                        sync_global_from_guest(vm, nr_writes);

@@ -807,7 +811,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 static void help(char *name)
 {
        puts("");
-       printf("usage: %s [-h] [-i iterations] [-I interval] "
+       printf("usage: %s [-h] [-i iterations] [-I interval] [-u unit] "
               "[-p offset] [-m mode]\n", name);
        puts("");
        printf(" -c: hint to dirty ring size, in number of entries\n");
@@ -815,8 +819,9 @@ static void help(char *name)
               TEST_DIRTY_RING_COUNT);
        printf(" -i: specify iteration counts (default: %"PRIu64")\n",
               TEST_HOST_LOOP_N);
-       printf(" -I: specify interval in ms (default: %"PRIu64" ms)\n",
+       printf(" -I: specify interval in unit (default: %"PRIu64")\n",
               TEST_HOST_LOOP_INTERVAL);
+       printf(" -u: specify unit in ms (default: 1)\n");
        printf(" -p: specify guest physical test memory offset\n"
               "     Warning: a low offset can conflict with the loaded test code.\n");
        printf(" -M: specify the host logging mode "
@@ -832,6 +837,7 @@ int main(int argc, char *argv[])
        struct test_params p = {
                .iterations = TEST_HOST_LOOP_N,
                .interval = TEST_HOST_LOOP_INTERVAL,
+               .unit = TEST_HOST_LOOP_UNIT,
        };
        int opt, i;

@@ -840,7 +846,7 @@ int main(int argc, char *argv[])

        guest_modes_append_default();

-       while ((opt = getopt(argc, argv, "c:hi:I:p:m:M:")) != -1) {
+       while ((opt = getopt(argc, argv, "c:hi:I:u:p:m:M:")) != -1) {
                switch (opt) {
                case 'c':
                        test_dirty_ring_count = strtol(optarg, NULL, 10);
@@ -851,6 +857,9 @@ int main(int argc, char *argv[])
                case 'I':
                        p.interval = strtol(optarg, NULL, 10);
                        break;
+               case 'u':
+                       p.unit = strtol(optarg, NULL, 10);
+                       break;
                case 'p':
                        p.phys_offset = strtoull(optarg, NULL, 0);
                        break;
@@ -886,9 +895,10 @@ int main(int argc, char *argv[])

        TEST_ASSERT(p.iterations > 0, "Iterations must be greater than zero");
        TEST_ASSERT(p.interval > 0, "Interval must be greater than zero");
+       TEST_ASSERT(p.unit > 0, "Unit must be greater than zero");

-       pr_info("Test iterations: %"PRIu64", interval: %"PRIu64" (ms)\n",
-               p.iterations, p.interval);
+       pr_info("Test iterations: %"PRIu64", interval: %"PRIu64", unit: %"PRIu64" (ms)\n",
+               p.iterations, p.interval, p.unit);

        if (host_log_mode_option == LOG_MODE_ALL) {
                /* Run each log mode */
--
2.43.0
