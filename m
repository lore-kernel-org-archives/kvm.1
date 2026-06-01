Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCD7345CAA
	for <kvm@vger.kernel.org>; Mon,  1 Jun 2026 20:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780344164; cv=none; b=p9Zqew/nuPkL+hOo+R5VqJjG5svMA1KmDNWjZEiJyNTysg5I8ySdXER6vbLuZyDyXMB8Yl1bTr2IaKCp1FyihgPuYmBv6LnkI1yU/IdvCWiFe+RtOjiqCfg0jgAizoSpclL/LyRx0vmg1ZtPtWvFy0ZHsw7sUpHWtiK0Y9Eq4IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780344164; c=relaxed/simple;
	bh=C1uCNZIP1HQRli7PoBH8kDgdXlNWae0bh0TuHDr6UFY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lp8GHjZZP6JM5Scrl/KBEfUwAad7774allzZiA0JY5fWpcvyr0FwpapE3y9bN5UGqvg0/CDQKlGKXmmtVidfaB4yfwzXaSUtV89hueIhJrxd7w7CkbvZlb2PxoSI5deARnMBt2uuIR8E5bIG5Lo3sCaVzjDDQuGuZSKx6KbNvlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZCVRySE; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZCVRySE"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c85a2c0b56fso1861272a12.0
        for <kvm@vger.kernel.org>; Mon, 01 Jun 2026 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780344162; x=1780948962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACWAV5pEQNZNHB+r5tUvjzX0G30bImUmGGS6ry50Smw=;
        b=XZCVRySE2BWPX/1COd8eJM//2qIgSCVPzhYBOUeJCUrmxPMdF1e/zm/JO5Jh4Adydd
         w6GjjojSHPIE5bvTmf82jIKRf5pu806XNJ6lSaBewig/z0skZpJvmzDrST6GkPlztUHF
         oSmPZOklP4Mtukty8k2R6OOqWl+M70yW0peVj+7N8WgVyH4CvzOyNzSKiLrqa9nKLLY1
         Xb6fmCbOtlrY5D4+kKo10jsGRt/2UTxifjSzXvGuR4NDxI+k8ZKcNwAqYxsXyRULDVsF
         XPcdVz/3M4pDQxzSCgv/6FiF0z2ZyPm3RujL3MWN4zUFMfEmwzkLmgpYOoilqJwmYjz7
         oQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780344162; x=1780948962;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ACWAV5pEQNZNHB+r5tUvjzX0G30bImUmGGS6ry50Smw=;
        b=WjEcex9m3x8TqVuTUx6aGUrGOq0ewMVvo77KisoMbQtfB0SqLDgjGHYqpAXvs9Gl3j
         NovzbnEi92bCXvOAKszbhd2V0CWcXu9tHGpdkib6P+qJ1s4MRi0+ymjsZrQ++TU6gp13
         6x8NkB8tib86RmzS47SKO8wX/DXPaUfDV6dRjWHHhtXcWkXc57hduCIFdEwitMKK7/sD
         OtGak2Lh5GtRi9Mk5bNPLB9WHZ+bQ7Cn5jBQ2lp/S2aXcsdXdkhNgdU4OHgPeSKQ383T
         dSJEIy3IWQNKy/KkSA5piACG8ntVPGyFU6M6a4H7uOmpCiJZoum8Z91OU29HoaiLRkIN
         e6Xw==
X-Forwarded-Encrypted: i=1; AFNElJ89W5MLwZyAKFlS6BBG7se0zm6PtQX+1wuvik2KBqcDR1p/yVWneaIiyhCc0eLe38ncucs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQ6qZ5vBXcJHrdCkPFlIh+WzfoK/vPduBKFrR/E4wLjWyJ25F
	kVQZB/Sa5stJ85zsEXckQgaOYxoW2MPIAG4YvSfA0nmFIA/+49hll/MPstbe8YP8XmOdvvz2ciY
	KC8zo+w==
X-Received: from pgbcp1.prod.google.com ([2002:a05:6a02:4001:b0:c82:7c27:98a8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:492:b0:3b4:7758:e397
 with SMTP id adf61e73a8af0-3b477590e85mr1077789637.16.1780344162217; Mon, 01
 Jun 2026 13:02:42 -0700 (PDT)
Date: Mon, 1 Jun 2026 13:02:41 -0700
In-Reply-To: <20260530002134.558837-9-jrhilke@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260530002134.558837-1-jrhilke@google.com> <20260530002134.558837-9-jrhilke@google.com>
Message-ID: <ah3lYRgwU5QebVt1@google.com>
Subject: Re: [PATCH v4 08/19] KVM: selftests: Verify interrupts are received
 when IRQ affinity changes in IRQ test
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026, Josh Hilke wrote:
> @@ -134,17 +137,21 @@ int main(int argc, char **argv)
>  	u32 gsi =3D kvm_random_u64_in_range(&kvm_rng, 24, KVM_MAX_IRQ_ROUTES - =
1);
>  	u8 vector =3D kvm_random_u64_in_range(&kvm_rng, 32, UINT8_MAX);
> =20
> +	int i, j, c, msi, irq, eventfd, irq_cpu;

This fails to build with -Werror:

irq_test.c: In function =E2=80=98main=E2=80=99:
irq_test.c:183:35: error: =E2=80=98irq=E2=80=99 may be used uninitialized [=
-Werror=3Dmaybe-uninitialized]
  183 |                 irq_affinity_fp =3D open_proc_irq_affinity(irq);
      |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
irq_test.c:140:27: note: =E2=80=98irq=E2=80=99 was declared here
  140 |         int i, j, c, msi, irq, eventfd, irq_cpu;
      |                           ^~~
irq_test.c:228:41: error: =E2=80=98irq_cpu=E2=80=99 may be used uninitializ=
ed [-Werror=3Dmaybe-uninitialized]
  228 |                                         printf("  irq_cpu: %d\n", i=
rq_cpu);
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
irq_test.c:140:41: note: =E2=80=98irq_cpu=E2=80=99 was declared here
  140 |         int i, j, c, msi, irq, eventfd, irq_cpu;
      |                                         ^~~~~~~

The first one (of three distinct uses) is easy enough to solve:

diff --git a/tools/testing/selftests/kvm/irq_test.c b/tools/testing/selftes=
ts/kvm/irq_test.c
index 29f54a435c8e..23c82ddee6b9 100644
--- a/tools/testing/selftests/kvm/irq_test.c
+++ b/tools/testing/selftests/kvm/irq_test.c
@@ -251,15 +251,16 @@ int main(int argc, char **argv)
                eventfd =3D device->msi_eventfds[msi];
                printf("Using device %s MSI-X[%d] (IRQ-%d)\n", device_bdf, =
msi,
                       irq);
+
+               if (irq_affinity)
+                       irq_affinity_fp =3D open_proc_irq_affinity(irq);
        } else {
+               TEST_ASSERT(!irq_affinity,
+                           "Setting IRQ affinity (-a) requires a backing d=
evice (-d)");
+
                eventfd =3D kvm_new_eventfd();
        }
=20
-       if (irq_affinity) {
-               TEST_ASSERT(device_bdf, "-a requires -d");
-               irq_affinity_fp =3D open_proc_irq_affinity(irq);
-       }
-
        printf("Injecting interrupts for GSI %d (Vector 0x%x) %d times\n",
               gsi, vector, nr_irqs);
=20

And the second can be addressed by checking irq_affinity_fp instead of irq_=
affinity:

@@ -298,7 +299,7 @@ int main(int argc, char **argv)
=20
                kvm_route_msi(vm, gsi, vcpu, vector, do_use_nmi);
=20
-               if (irq_affinity && vcpu->id =3D=3D 0) {
+               if (irq_affinity_fp && vcpu->id =3D=3D 0) {
                        irq_cpu =3D kvm_random_u64(&kvm_rng) % get_nprocs()=
;
                        write_proc_irq_affinity(irq_affinity_fp, irq, irq_c=
pu);
                }

but I don't think that's quite correct.  Keying off vCPU0 for task migratio=
n
makes sense, because the test round-robins IRQs to each vCPU, so it's logic=
al to
redo task/vCPU affinity after every round.

But IRQs are being spread over _all_ host CPUs, and there is no round-robin
behavior, it's completely random.  So rather than rate-limit based on numbe=
r of
vCPUs, I think it makes more sense to hardcode the changes in affinity, e.g=
.

		if (irq_affinity_fp && !(i % 10)) {
			irq_cpu =3D kvm_random_u64(&kvm_rng) % get_nprocs();
			write_proc_irq_affinity(irq_affinity_fp, irq, irq_cpu);
		}


Sadly, even that doesn't address the third "used uninitialized" issue:

irq_test.c:334:41: error: =E2=80=98irq_cpu=E2=80=99 may be used uninitializ=
ed [-Werror=3Dmaybe-uninitialized]
  334 |                                         printf("  irq_cpu: %d\n", i=
rq_cpu);
      |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~


because apparently gcc isn't smart enough to understand that "!(i % 10)" (o=
r
even "!i" is guaranteed to run on the first iteration.  However, that's fal=
se
positive probably a blessing in disguise, because it highlights that printi=
ng
only what userspace has _requested_ could be very misleading, given that th=
e
whole point of the offending printf() is to spit out information when the I=
RQ
got lost.

Writing smp_affinity_list (or smp_affinity) does NOT guarantee the new affi=
nity
is realized in hardware.  E.g. the kernel typically "lazily" migrates IRQs,=
 and
only actually changes the affinity when an IRQ actually arrives.  To see wh=
at
CPU an IRQ is actually wired up to, you need to read /proc/<irq>/effective_=
affinity{,list}.

As it pertains to the "used uninitialized" flaw, I think the test should sp=
it
out three things:

 1. irq_cpu, i.e. what the test thought it set the affinity to
 2. /proc/<irq>/smp_affinity, i.e. what the kernel has for the allowed list
 3. /proc/<irq>/effective_affinity, i.e. what the actual, current affinity =
is

And then _if_ you want to ratelimit changes in affinity, fix the "used unin=
itialized"
issue by explicitly initializing irq_cpu, with a comment calling out that t=
he
compiler is being stupid.

@@ -287,6 +288,12 @@ int main(int argc, char **argv)
                }
        }
=20
+       /*
+        * Suppress a false positive maybe-uninitialized compiler warning d=
ue
+        * to ratelimiting changes in IRQ affinity.
+        */
+       irq_cpu =3D -1;
+
        for (i =3D 0; i < nr_irqs; i++) {
                const bool do_clear_routes =3D clear_routes && (i & BIT(3))=
;
                const bool do_use_nmi =3D use_nmi && (i & BIT(2));
@@ -298,7 +305,7 @@ int main(int argc, char **argv)
=20
                kvm_route_msi(vm, gsi, vcpu, vector, do_use_nmi);
=20
-               if (irq_affinity && vcpu->id =3D=3D 0) {
+               if (irq_affinity_fp && !(i % 10)) {
                        irq_cpu =3D kvm_random_u64(&kvm_rng) % get_nprocs()=
;
                        write_proc_irq_affinity(irq_affinity_fp, irq, irq_c=
pu);
                }
@@ -329,7 +336,7 @@ int main(int argc, char **argv)
                                printf("Timeout waiting for interrupt!\n");
                                printf("  vCPU: %d\n", vcpu->id);
                                printf("  is interrupt NMI: %s\n", do_use_n=
mi ? "true" : "false");
-                               if (irq_affinity)
+                               if (irq_affinity_fp)
                                        printf("  irq_cpu: %d\n", irq_cpu);
                                if (migrate_vcpus)
                                        kvm_print_vcpu_affinity(vcpu, vcpu_=
tids[vcpu->id]);

But honestly, unless it impacts the runtime, I don't see much value in rate=
limiting
changes in IRQ affinity.  Putting that much stress on the IRQ subsystem is =
actually
probably interesting.

And no matter what, /proc/<irq>/effective_affinity needs to be printed on f=
ailure.
