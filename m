Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218571;
	b=sDh7DxVZrcA06DlkM1Crd4gw1yfRTZS02mM0M/fDNNpr+3B0000dK2KMzJhisBBJY7yb
	 RjuwCzVkMELxsqmiBeQTi6ghl0IA4yq4Op5Slj6wFNUDw4+NwCxLGzwstnUyLZFAhRKLG
	 yEWsHq9nyh1EVJMJGp0q7YOSjKSOarHI0DtmU3Skn7y/Tbw7/77jq7tqidE1HdJs6HOAw
	 v43HTTlzsxG+HwuximZPHezfaY0JIRX0lfPwcf6O9szr2bJ4un3uH6qgH829vao6lRgtT
	 bs5NuTPIm9yy/4PpUWb6BN1Qi9iDT3OJGPLU3Edfo/+C2x4Sv/J2cFpn6oRRC2/LJWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218571;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZHO8zY3zGR66Z83umM/amjj6Zf6URUWKg1d+imcElEc=;
	b=r7YZJVd+H3sVnN8gPXUUVEzTB6Zt1HKbJ9NT969B0JhjvvlIRKABwM1vfTEk6AbtQQ7g
	 fieH6fUfXWAlkn2TfATQf7HsJ7Lw6TbAZelVBkcM2Hw8cBhe5CR4h03jWvssYypIvXqJj
	 LSvF9Tb4kQVkHyhWjtMHO4hoLsIOuOUr+8Oh6wMwiUXtmjhrf5Lfp5H8NjxGsr6WQ+ZFn
	 ajK19PKZFy6HCCvS3sbDjvuCfLAe3opnokvdcpDTVMXUeptuij93cvPbg+onqXubOKB5w
	 FwYMs0A91/4kavF1bFre3Zj2lCROBpsjjDNhUAZ9Nf0h6yZZL8U/McvZZPHHINj1G0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m85aBDwY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FB606A327
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m85aBDwY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BE01F031E4
	for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 20:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218566;
	bh=ZHO8zY3zGR66Z83umM/amjj6Zf6URUWKg1d+imcElEc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m85aBDwYVoTxHlA93Rs9c4CNVI+77+sHYacMo772vyIG+3aqIh/wpc/3W6uzPKh2O
	 sR7MGVq3Uxd9ft3P8SHjP0vWLAI4k2Cj3F2Uq5sptikozV2OLqcPwE+jtO6hAQdaRp
	 KaZA3R7apv5yEaU2yNW4WqVqCOyvv1tUmc7P9yRj8Uyiuo8aMS+JlSOqoULQv5ggwf
	 Ty2R9l36BbhZUGrmAqcwuzIyrUO+iZ+pZNQeooswoXOM7VDYrDLUSVCvA0U/4aFUgt
	 cHabCvl1r3YUBdNQheE3nqpnyOnyML7tUPEnv3zvbiepGrQcXudh6qCO3rjEY0nbz+
	 UuPI/6n+0MGfA==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c434376dbebso11370866b.1
        for <kvm@vger.kernel.org>; Wed, 28 Oct 2026 13:16:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwr06UNUG/cl5qBk8MYUlOimLc+dQpKoGcFv1BbWtuel6d1+tDFQoX5xIVJwgdC3pZd600=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6YJ6H9jpNNVM3HTldR91xa8KGfqAJafJkWBzc7eutuI0wvRFQ
	DEtfwqFqvaUZi666uZrgrQDJHpsCktF74wGZ3yObP5oxKWSDNTBLwXP62HxkL4G/btW19dVsrw1
	/2Ijr2TnrFSgjSqGfm53oGKDdJdY9Jr8=
X-Received: by 2002:a17:907:7294:b0:c49:8bf8:a7a7 with SMTP id
 a640c23a62f3a-c49d1123fb8mr54251666b.7.1793218565180; Wed, 28 Oct 2026
 13:16:05 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAHCio2jc9++n2Qoa0-sNkObZsWOybSwK1X2aBjFirchjRTBZsQ@mail.gmail.com>
 <CAHCio2hpL+Y0iYdGXs5zKA-81+w_9pHs+tZPe2uaYKs8yOCz_w@mail.gmail.com>
In-Reply-To: <CAHCio2hpL+Y0iYdGXs5zKA-81+w_9pHs+tZPe2uaYKs8yOCz_w@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 28 Oct 2026 13:15:53 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMBcU_s3Dpc99jse=n7Njhy8Ly-daf6--YXVD+Cw_ed1w@mail.gmail.com>
X-Gm-Features: AclHuK8qYQ4fqzpFfJa07mPN-tFBit3XuauYAYoKnvWdLnpbGGbkMARbTUkZ00c
Message-ID: <CAO9r8zMBcU_s3Dpc99jse=n7Njhy8Ly-daf6--YXVD+Cw_ed1w@mail.gmail.com>
Subject: Re: Some options abort RFC: KVM: SVM: Rework ASID management
To: Jackie Yu <ufo19890607@gmail.com>
Cc: jmattson@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mlevitsk@redhat.com, pbonzini@redhat.com, seanjc@google.com, 
	thomas.lendacky@amd.com, vkuznets@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 6:37=E2=80=AFAM Jackie Yu <ufo19890607@gmail.com> w=
rote:
>
> Hi, guys!
>
> Jackie Yu <ufo19890607@gmail.com> =E4=BA=8E2026=E5=B9=B410=E6=9C=8828=E6=
=97=A5=E5=91=A8=E4=B8=89 21:36=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Hi Yosry and KVM folks,
>>
>> We would appreciate your guidance on supporting INVLPGB in ordinary (non=
-SEV)
>> L1 guests alongside the proposed static per-vCPU ASIDs.
>>
>> The 2025 ASID rework RFC proposed one static ASID per L1 VM and listed
>> "enabling INVLPGB virtualization" among its motivations [1]. The June
>> 2026 RFC v2 changed the design from per-VM to per-vCPU ASIDs [2]. In
>> the October v2 series, patches 2-11 establish static per-vCPU ASIDs,
>> while the remaining patches primarily address nested TLB flushes [3].
>> Our question is how guest INVLPGB should be supported under the
>> per-vCPU design.
>>
>> Some of our workloads frequently discard and repopulate memory using
>> patterns involving madvise() and memset(). Broadcast IPI-based TLB
>> shootdowns are expensive for these workloads, so we are interested in
>> making AMD INVLPGB available to guests. We use a small benchmark to
>> approximate the resulting shared-address-space pressure:
>>
>>     region =3D mmap(256 MiB, MAP_SHARED | MAP_ANONYMOUS);
>>     memset(region, 0xab, 256 MiB);       // Initial population
>>     start N workers, pinned across 64 allowed CPUs;
>>     each worker repeatedly reads pages in its own slice of region;
>>
>>     repeat 500 warmup + 2,000 measured iterations:
>>         start =3D clock_gettime(CLOCK_MONOTONIC);
>>         madvise(region, 256 MiB, MADV_DONTNEED);
>>         record elapsed madvise() time;
>>         write one page in every 64 pages to repopulate part of region;
>>
>>     stop and join the workers;
>>
>> The benchmark uses memset() for initial population; subsequent
>> iterations re-touch pages rather than repeatedly calling memset().
>> The numbers below measure the advisor thread's madvise() syscall
>> latency, not worker throughput.
>>
>> In our experimental KVM4 configuration with a VM-shared ASID and our
>> separate guest INVLPGB passthrough changes, we observed:
>>
>>                          INVLPGB off     INVLPGB on    Difference
>>     64 workers  mean       21.624 ms       12.505 ms     -42.17%
>>                 P99        32.760 ms       21.518 ms     -34.32%
>>     128 workers mean       29.553 ms       20.459 ms     -30.77%
>>                 P99        39.628 ms       28.160 ms     -28.94%
>>
>> These are single, sequential A/B runs for each worker count, with
>> 500 warmup and 2,000 measured calls per run. The process had 64
>> allowed CPUs, so the 128-worker case was oversubscribed. The
>> measurements show a useful latency difference, but do not by
>> themselves establish INVLPGB instruction counts or IPI reductions.
>>
>> We then experimentally combined the October per-vCPU ASID changes for
>> ordinary guests with our existing, out-of-tree L1 INVLPGB/TLBSYNC
>> passthrough. With guest INVLPGB enabled, a one-vCPU guest boots, but
>> otherwise comparable two-vCPU and 64-vCPU guests fail early during
>> boot. Keeping QEMU's +invlpgb setting while adding clearcpuid=3D419
>> to the same guest kernel allows the multi-vCPU guest to boot; the
>> guest logs "Clearing CPUID bits: invlpgb".

I imagine for INVLPGB to work correctly with per-vCPU ASIDs, you need
to intercept INVLPGB and basically issue an INVLPGB for each ASID used
by this VM (nr_vcpus or 2 * nr_vcpus with nested). I can't imagine
this would perform well on large VMs, not sure if virtualizing INVLPGB
would still make sense.

Regarding the boot failure, I would guess there are some missing cases
due to the complexity of emulating INVLPGB without a shared per-VM
ASID.

>> These controlled boot comparisons identify a problem with combining
>> static per-vCPU ASIDs and direct guest INVLPGB/TLBSYNC passthrough:
>> the multi-vCPU guest fails to boot when it uses INVLPGB, but boots
>> when its INVLPGB CPUID bit is cleared. A one-vCPU guest also boots
>> with INVLPGB enabled.
>>
>> In this configuration, an unintercepted guest INVLPGB targets the
>> invoking vCPU's hardware ASID, while sibling vCPUs have distinct
>> ASIDs.

It's neat that INVLPGB will automatically use the current ASID and not
ASID=3D0 for guest usage.

>> The October ASID rework does not add handling to extend that
>> guest broadcast invalidation to sibling ASIDs. Consequently, direct
>> passthrough does not preserve the required multi-vCPU guest
>> invalidation semantics. This problem arises when our out-of-tree
>> passthrough is combined with the per-vCPU ASID scheme; it is not a
>> claim that the upstream ASID series alone causes a boot failure.
>> The earlier discussion of guest INVLPGB and global ASIDs is relevant
>> here [4].
>>
>> Could you advise on the preferred upstream direction?

This is a question for Sean and Paolo.

It is possible to use one ASID per-VM, however:
1. It adds complexity as we need to track what vCPU in a VM ran last
on a CPU, so that we can flush the shared ASID in between different
vCPUs running on the same CPU.
2. It adds some TLB flushes due to scenario (1), not sure how much
this matters in practice.
3. It will re-establish a divergence in ASID/VPID management between
AMD and Intel, unless we also switch VMX to per-VM ASIDs, but I am not
sure if there's any benefit to this for now.

>>
>>   1. Would an opt-in, VM-scoped ASID mode for ordinary VMs that expose
>>      guest INVLPGB be acceptable, while other VMs retain per-vCPU
>>      ASIDs? This would require a properly managed shared-ASID lifetime
>>      and flush/reuse semantics, rather than simply giving vCPUs the
>>      same VMCB ASID value.
>>
>>   2. Alternatively, is the intended direction to retain per-vCPU
>>      ASIDs and intercept/virtualize guest INVLPGB and TLBSYNC, so that
>>      a guest broadcast invalidation correctly covers the relevant
>>      sibling vCPU ASIDs and preserves the required ordering?
>>
>>   3. If neither approach is currently planned, should ordinary
>>      multi-vCPU guests be prevented from enabling INVLPGB until the
>>      required semantics exist?
>>
>> We can share the madvise benchmark and its measurement methodology,
>> and would be happy to compare the same benchmark under both proposed
>> designs. We would appreciate feedback on the preferred upstream
>> architecture before pursuing a downstream implementation.
>>
>> References:
>> [1] 2025 ASID rework RFC (per-VM):
>>     https://patchew.org/linux/20250326193619.3714986-1-yosry.ahmed@linux=
.dev
>> [2] June 2026 RFC v2 (per-VM to per-vCPU):
>>     https://lore.kernel.org/kvm/20260616004155.1435766-1-yosry@kernel.or=
g/
>> [3] October 2026 v2 series:
>>     https://lore.kernel.org/kvm/20261008001425.2458927-1-yosry@kernel.or=
g/
>> [4] Discussion of non-SEV guest INVLPGB and global ASIDs:
>>     https://patchew.org/linux/20250223194943.3518952-1-riel@surriel.com/=
20250223194943.3518952-7-riel@surriel.com
>>
>> Best regards,
>> Wind Yu
