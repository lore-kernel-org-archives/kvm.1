Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795846359;
	b=3OtnA8psyYHwVXm3Y3V+aNOwdL6/lUNFoj92gxmzdOIpQyMipGH8Ed4iEVZfR8m4co5A
	 nVBnxr5owoHFTkMmc6VUH0pwgwUnarHIvtUJ9VgP9i/gFO1Jy0AYj2d/ollnQqJ2SmoHX
	 OLun1wmUSJkQLAA019GZr2NW57mBUH1X2z3prfyW9xc6ysC8QcMMQDyNav+iE30Ian1AF
	 eM2MFALF3KJotRxrpaQreJ8ZmwfGQdIQc74t56vy7uJLRbVlxua/lWmCW8U8jc608URm2
	 FHfAkYuomGQffdTDjyoEp5bFiKcmlT2/Mdbywj+2Tq0cTwQX8rrVF4YgJSQOwaMcZNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795846359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AvvYwc8dXmZ/xx+ZtI1OzAYTQVoksKNWkwo9zAxLQjg=;
	b=c6E7+16TJaIbV+k6y67RfGkFYrJcW3WYwiySgDf7YxNZKpu3YV6kCAYTfQ8uXzIKXfmS
	 gmG/W06PJ4rDct0Iwxmd7x3vDt0EdkZSLs+k8iA9Alg8KsCrqJhcwDOCCe2O16lY9tnRN
	 rRgYdlgkopHd/DkXtTTMJ4k1Cd2iJfWOQIKzGyhotV5F6O5ezyt1FhtkbN4OZC6wn8+aT
	 fuSy7im6ueCUltW+IraPl4dpU1jdnOIMw+Vd3gl4FHdo5VQ55vWZUh6iNHU3nbAknCwRh
	 n8cf+xjpsWlKmZHtO0eTZZ8TFsdD/wSMzeUCC0QdZlbC8num3GGR3/L1W08qJCGrq3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hk72WYpT;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB123606A31C
	for <kvm@vger.kernel.org>; Sat, 28 Nov 2026 06:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB123606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hk72WYpT
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so5475375f8f.2
        for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 22:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795846357; x=1796451157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AvvYwc8dXmZ/xx+ZtI1OzAYTQVoksKNWkwo9zAxLQjg=;
        b=hk72WYpTPsx+Yq9bnoq4jyBfMQrGldO/7hil2B+ZaPNW2ptkXa649LJLiSlhO5pxrb
         ly5VwROAcbAAQL7CMms3IX1CtDZgxt3wYs+6t2ArULRfu19k5kP8mH53tOUT3UcS6VWV
         rOoGWx5WL5LGB8tAv0k3iAx1azVq32RAB9jxaWrRuAwG8gH4fuKGnehH9n7XyupNlBhA
         4gdXlawck8SmTyQRct/jUh1YEkwDubAIXGCfKKdu6MOopmsi5P4oD5PHOZMDf9a5ukEC
         Csxr6SO91b8jQfEWxGmdejjxF3Vurrm6nzC6hntkpq3exD9ff55kfiiEY23HjalOA+im
         pMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795846357; x=1796451157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AvvYwc8dXmZ/xx+ZtI1OzAYTQVoksKNWkwo9zAxLQjg=;
        b=27T+aD/q0BB5K4rF+PxqPZ1MiEngAQ3LrkSKKDdUMsdPokTZkM2Yj5pCa0mzwWCdI4
         KJkYAhW2P+1UJMbZkpoLmGb/FC8s9jsQzy4Ax3km7mYfZDAQ5h+bk6AsgBLHRcugcQz1
         Oo7zw6+Z8WmdeCEovwU+0mxuqBWKKJGO8ew75hiFpwUcqG58kwAog4R5+DpxNI9uOQ70
         P9zaYZkecbJUA38l0LN2ed6S8Dyl9z/0WPa7o91PZYeE+oLJ7Jv4UCfWUpJTJ+7ZuWdX
         h4DMyPnn5QL8QasOhJ4DQ+Bd4VfAVX6ZDPdEWXPVd5RTge0YId4iMX2Oy/7tiVwfxh0I
         Y5Eg==
X-Gm-Message-State: APuU4Z9McFsvPrkA3xVfG0T+/TUEwYS9KJKE3mfJwQRaHWXTfovKPhLL
	IkXqPYTZkFvTZiJJG+92w3UdCOpEVrSdbl+9Nk5dpb6MXsvSROjtAtgP
X-Gm-Gg: AZFdTZfjacARP/SLdDe0O4Kx3HNSf88rx07YwYbom16eoe1605BC56OP21FNsptcF+7
	D8HCaEYDsqXl97/EAOO94liZuxOaNOmQW09p5vnOB9wgF7LhDx9DWNHYksoYyJV6zbVwO5XYPgn
	x7IoRniTuc/BPA8A8PVN1v97sYQ/HUlItU4Xh7ynLlbw7ogNBZGIAGj7nahRX1N01K0UDomQ8YC
	MDsyf2Aa5BtGiueTlSSUAIe9DhSsRUyXjx1So5TwRu/QQIk4rOOx4jplXflEZmyEEQqBIPnS4y5
	/yn5Rk59BbZlSQo9X16QT0W/0rEbgaC84zIw3Q0PCTxX8wyfC+ZUMmXse5NWmNgSm1Vs05qHE1U
	KK+IYe8bygp1LKFo9z2PHKg+VgJ1e6NpLPEn9uSofbrrfckX1lACEGrzq+9MsfB9C2PZaCrZVT6
	QDg+ZeeE9uGHgshh88JQ9gWy3EWEY3u7EZ++mv8qgw7i97xGxqmeMtWal/0rWoXLb/P01MSWI7D
	60h7+teSwi1ZjBdbU2ScrHFNvnJBme78AFxiP9faDbTMLi9OQbORbi7rHsn7MyBV+WAkLyf4h7y
	earOSDETJqN1pqgKFrBOcVyZ071yNkWzt9XFfEfEWQ==
X-Received: by 2002:a05:6000:1846:b0:4af:e519:ccce with SMTP id ffacd0b85a97d-4afe519cec9mr50443665f8f.6.1795846356955;
        Fri, 27 Nov 2026 22:12:36 -0800 (PST)
Received: from IsoOmenaM3 ([91.136.216.173])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b1ebsm52180937f8f.33.2026.11.27.22.12.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 22:12:35 -0800 (PST)
From: Mika Tammi <mikatammi@gmail.com>
To: Will Deacon <will@kernel.org>,
	Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: kvm@vger.kernel.org,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	Mika Tammi <mikatammi@gmail.com>
Subject: [PATCH kvmtool] Set the VCPU affinity with sched_setaffinity() (for musl compatibility)
Date: Sat, 28 Nov 2026 07:12:32 +0100
Message-ID: <20261128061232.64870-1-mikatammi@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 4c90ccf4c593 ("Correctly apply --vcpu-affinity to the VCPU
threads") creates the VCPU threads with pthread_attr_setaffinity_np().
That is a glibc extension, which musl doesn't have, so kvmtool no longer
builds with musl:

  util/util.c:221:23: error: implicit declaration of function 'pthread_attr_setaffinity_np'; did you mean 'pthread_setaffinity_np'? [-Wimplicit-function-declaration]

musl can only set the affinity of a thread that already exists. If the
thread that creates a VCPU thread did that, the VCPU could run before
its affinity is in place, and on arm64 KVM_RUN fails on a CPU that the
VCPU's PMU doesn't support. So have each VCPU thread set its own
affinity as the first thing it does, with sched_setaffinity(), as
kvmtool called it before that commit. As that commit intended, only the
VCPU threads get the affinity.

Fixes: 4c90ccf4c593 ("Correctly apply --vcpu-affinity to the VCPU threads")
Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Mika Tammi <mikatammi@gmail.com>
---
Tested with nixpkgs' kvmtool package at kvmtool master (4b4aceb1dae7).
The x86_64 builds with musl, dynamic and static, fail as above and
build with this patch, as do x86_64 with glibc and cross builds for
arm64, riscv32 and riscv64. On an 8-CPU x86_64 host with
-c 2 --vcpu-affinity 2-3, the VCPU threads may run only on CPUs 2-3 and
the other threads that lkvm creates on all eight, with glibc and musl
alike and as with master's glibc build, and the guest boots. A static
musl lkvm on QEMU rv32 and rv64 KVM hosts boots a guest with
--vcpu-affinity 0. For arm64 I could only compile it.

With CPUs that can't be used, each VCPU thread now fails with
"sched_setaffinity: Invalid argument", where pthread_create() failed
before.

kvm_create_vcpu_thread() no longer uses its kvm argument. I left it
alone to keep this fix small, and can send a cleanup on top if you
would like one.

 builtin-run.c | 14 ++++++++++++++
 util/util.c   | 19 +------------------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/builtin-run.c b/builtin-run.c
index f06231e..e366ce9 100644
--- a/builtin-run.c
+++ b/builtin-run.c
@@ -323,10 +323,24 @@ out_free:
 
 static void *kvm_cpu_thread(void *arg)
 {
+	cpu_set_t *affinity;
 	char name[16];
+	int ret;
 
 	current_kvm_cpu = arg;
 
+	/*
+	 * The thread sets its own affinity, before it runs the VCPU.
+	 * pthread_attr_setaffinity_np() could create the thread with it,
+	 * but is a glibc extension, which musl doesn't have.
+	 */
+	affinity = current_kvm_cpu->kvm->vcpu_affinity;
+	if (affinity) {
+		ret = sched_setaffinity(0, sizeof(cpu_set_t), affinity);
+		if (ret == -1)
+			die_perror("sched_setaffinity");
+	}
+
 	sprintf(name, "kvm-vcpu-%lu", current_kvm_cpu->cpu_id);
 	kvm__set_thread_name(name);
 
diff --git a/util/util.c b/util/util.c
index c4ee033..59855d6 100644
--- a/util/util.c
+++ b/util/util.c
@@ -210,29 +210,12 @@ void *mmap_guest_memfd(struct kvm *kvm, u64 size)
 int kvm_create_vcpu_thread(struct kvm *kvm, pthread_t *thread,
 			   void *(*start_routine)(void *), void *arg)
 {
-	pthread_attr_t attr;
-	cpu_set_t *affinity;
 	int ret;
 
-	pthread_attr_init(&attr);
-
-	affinity = kvm->vcpu_affinity;
-	if (affinity) {
-		ret = pthread_attr_setaffinity_np(&attr, sizeof(cpu_set_t), affinity);
-		if (ret) {
-			/* Set errno so the caller can call die_perror(). */
-			errno = ret;
-			/* kvmtool treats a negative return value as an error. */
-			return -ret;
-		}
-	}
-
-	ret = pthread_create(thread, &attr, start_routine, arg);
+	ret = pthread_create(thread, NULL, start_routine, arg);
 	if (ret)
 		errno = ret;
 
-	pthread_attr_destroy(&attr);
-
 	return -ret;
 }
 
-- 
2.54.0 (Apple Git-157)

