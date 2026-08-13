Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A2C378D70
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615264; cv=none; b=D0gQbpmRF0oiCpRtnR+fFeA+hJzdq/f8U6p9gsaDLN4qctJ1jQBLJZojCTkgud5/I74LUPRQeW7Ko+3rXBc1jrthvx3wdeXaNstHz/RrhxOwDCqrP4AtLc+AN8bCZydA6SM1Srwwl2PynmvlmHcy0wdtSQwimR+baqo6ng5M+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615264; c=relaxed/simple;
	bh=xwHhJtXmE/tMZOCQVHdsdzkt9mIoc1LOZe8O7Nnsdf0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wkp5WTsBOstzCvBd0NWSAURJXS7/r6YPRy4LLU1Dn9RK0POYoB5WxfZpcF6COPgGQjnPPIOPOCn6ZGFqxadLqfdf4Esqgze4zGFL6qTBXZYeinx3odVDW5XHFqauYbSKod+E79oKUnxTzEFgEgOh3eSMvwdwzwUTfaIiuh6Yrkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffqa2nbA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffqa2nbA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001361F000E9;
	Thu, 13 Aug 2026 10:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786615263;
	bh=rJCQuGu/eEtqqA0UKYkgorWJq2n1YA1FMWjrDXkhYms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ffqa2nbA8flveuOOvRMGinoGulRjMb1ONfatm6XYIUaJmYv2J48e1wi+2cj1jrqSh
	 r8RGiT1omh+xp3UJbpoGwhFF5NQ5pBexamsb5mAIKyS8eym9noOppKAFczNYAJ6kMX
	 wTPTlTjC9N6l4AT9lKASmy8WV7ojFJVpCkuAEdkB0oWIUbNH3/fPTR1fJgmKWoxXwR
	 zJtJoJYoKbMs+T4yvUeuic4bu2VoNxo6zOfwD39q+wv4JeiTVkuDmF9IByLQ/d3ENZ
	 aL7t4x0axm7GtCH3pJJbHOOwONFxvAIxgy5zRS7v5SuZjtVS7mj5Br9gSm/AnAy97d
	 6Omg9Z5wQ1fTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] powerpc/perf: Update prev_count of event to get
 accurate values
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Menghani" <gautam@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260813094535.10083-4-gautam@linux.ibm.com>
References: <20260813094535.10083-1-gautam@linux.ibm.com>
 <20260813094535.10083-4-gautam@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 10:01:02 +0000
Message-Id: <20260813100103.001361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Missing atomic cmpxchg loop in vpa_pmu_read() when updating prev=
_count.

Pre-existing issues:
- [High] The VPA PMU `add` callback stores a raw pointer to `struct kvm_vcp=
u` in `event->pmu_private` without reference counting, leading to a Use-Aft=
er-Free.
--

--- Patch [3]: [PATCH v2 3/3] powerpc/perf: Update prev_count of event to g=
et accurate values ---
commit 7c392d724ba481a5282a90aed95397fac4533493
Author: Gautam Menghani <gautam@linux.ibm.com>

powerpc/perf: Update prev_count of event to get accurate values

This patch updates the VPA PMU read function to keep event->hw.prev_count
current. This prevents stale values from being returned on consecutive reads
while a process is running on a CPU.

> diff --git a/arch/powerpc/perf/vpa-pmu.c b/arch/powerpc/perf/vpa-pmu.c
> index e79d98447c743..efc39f71553bf 100644
> --- a/arch/powerpc/perf/vpa-pmu.c
> +++ b/arch/powerpc/perf/vpa-pmu.c
> @@ -156,6 +156,7 @@ static void vpa_pmu_read(struct perf_event *event)
>  	final_data =3D new_data - prev_data;
> =20
>  	local64_add(final_data, &event->count);
> +	local64_set(&event->hw.prev_count, new_data);

[Severity: Medium]
Is it safe to use local64_set() here without a local64_cmpxchg() loop?

If vpa_pmu_read() is interrupted by an NMI (such as a hardware PMI) and a B=
PF
program attached to the NMI reads the same event via bpf_perf_event_read(),
the nested read will calculate its delta and update prev_count.

When the outer vpa_pmu_read() resumes, it could calculate its delta using t=
he
old prev_data (resulting in double-counting the inner delta) and then
non-atomically overwrite prev_count.

Should this use a local64_cmpxchg() loop to safely update prev_count?

>  }
> =20
>  static void vpa_pmu_del(struct perf_event *event, int flags)

[Severity: High]
This is a pre-existing issue, but does this code leave a stale vcpu pointer
in event->pmu_private that can lead to a use-after-free?

Looking at vpa_pmu_add(), a raw pointer to struct kvm_vcpu is stored without
taking a reference:

arch/powerpc/perf/vpa-pmu.c:vpa_pmu_add() {
    ...
    vcpu =3D local_paca->kvm_hstate.kvm_vcpu;
    if (!vcpu)
        goto out;
    ...
    event->pmu_private =3D vcpu;
}

When the thread context-switches out, vpa_pmu_del() stops the event but
does not clear event->pmu_private to NULL. When the thread is scheduled
back in outside of KVM, vpa_pmu_add() sees the vcpu is NULL and returns
early, leaving the event active with the stale vcpu pointer.

If the VM is then destroyed and the vcpu freed, would a subsequent thread
exit or user read() calling vpa_pmu_read() trigger a use-after-free when
dereferencing vcpu->arch.l1_to_l2_cs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813094535.1008=
3-1-gautam@linux.ibm.com?part=3D3
