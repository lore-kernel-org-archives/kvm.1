Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55E43F0A2
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142132; cv=none; b=VUAvAjT7t2zvIR6tDkt8YatlQXve2NPC+xjtXpmky3vwEDL2AoeTpOUFfYoUtARCuo5OkO6mcajIMT/bG+7VBZC3fkQLBLt4JF5fx5J3NrUTGGtRr66pLnImIX3MwNGy2+Z9xg9MywcVlpu6sPdElCAhjgbIXblpuxHTPdRDKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142132; c=relaxed/simple;
	bh=j77alrfbvnCO0YNl6YJy549gRlmScGSVE2nSTsu2t5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxOklgonYe/9lZDQH7TyAoVeA6HX8HWozN8jCeUC5tiemL905uLje0K3BAhLqvqq13maDVHOokLo1Vxf9swgKKI69TfbtnuCMdEaafGrD+g6Sd+PJaRe5N9WW8iS+JTBETiYSQAkTbW9z9nx4fgCQMU4uepRGJ1A+1j6a7rNovw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLdyYyZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLdyYyZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5B61F00A3E
	for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 19:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784142118;
	bh=zEnU+s/1/zWxeu2dzngISTWBB6S+j8RtsiPGlrld318=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FLdyYyZh8SgOeKXLSr3Txuf+8Hy2ggLlo2hQmlG5GWOdoI244pb5W94ja5nDSuHkq
	 V16pLi57PSQE/PWWU4lwZfIMLH+mQ4b7gMpKBR0ZwPBRV3U6LAeV32AzOEiCkwSOq1
	 m7Mik61pQrVwcSTmoW6ct5FMaH9jaHEZwbmEBzr7D9JWrkieJJ3o2mc4gA7GT/G/KC
	 kRFnaDVuExxnfSXUBbT4/GzYuFJm/094Ko1qERGO3Lgb5QtEcI5j80cftMCeWABkPi
	 tK8gUE4v2e7qKAV2MN/kauKwuafFh9iCKltC+9vrMNIrqayhleerfymFgZMfMWWN+s
	 1rjEH9/jxrH2w==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15b509c323so755064766b.0
        for <kvm@vger.kernel.org>; Wed, 15 Jul 2026 12:01:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YyL+f0fMuKheOrLW57SEUuGCrgyBl5/1cBwz6JjaeOkD1U8X8Y8
	FKD6JwIhUNoh4IBlClOlNhBbqoA/u1CcyOwg8cr0qdhZzoBeqT/1r9Kb19/uPzLkT1wZq8k0tJE
	7mnHzq00wnxNyksd0AVJAB0Qy91vLD7A=
X-Received: by 2002:a05:6938:a093:10b0:c16:7e23:e83f with SMTP id
 a640c23a62f3a-c167e23ec4cmr145364066b.35.1784142116936; Wed, 15 Jul 2026
 12:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715063506.672432-1-nikunj@amd.com>
In-Reply-To: <20260715063506.672432-1-nikunj@amd.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 15 Jul 2026 12:01:45 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPAxp+qyB6gLAo5D8EZBdQy1XB4wWEeSReF3TsFx=3nnw@mail.gmail.com>
X-Gm-Features: AUfX_mzDqnZWGyRtkChm3EWHGEgw3OKZquAXB5ceg2zJNNGhwGy03OfoqcBXBxk
Message-ID: <CAO9r8zPAxp+qyB6gLAo5D8EZBdQy1XB4wWEeSReF3TsFx=3nnw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Bump asid_generation on CPU online to avoid
 ASID collision after hotplug
To: Nikunj A Dadhania <nikunj@amd.com>
Cc: kvm@vger.kernel.org, seanjc@google.com, pbonzini@redhat.com, 
	naveen.rao@amd.com, Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>, 
	Srikanth Aithal <Srikanth.Aithal@amd.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 11:35=E2=80=AFPM Nikunj A Dadhania <nikunj@amd.com>=
 wrote:
>
> If a vCPU stays scheduled out (or blocked) while the last pCPU it ran
> on goes through a hotplug cycle (online->offline->online), and the vCPU
> then resumes execution on the same pCPU, then it is possible for it to
> run with an ASID that has now been assigned to a different vCPU,
> resulting in stale TLB translations being used.
>
> svm_enable_virtualization_cpu() resets asid_generation to 1 and sets
> next_asid to max_asid + 1 on every CPU online event, including hotplug
> cycles.  Because next_asid starts beyond the pool boundary, the first
> call to new_asid() after an online event always wraps the pool,
> incrementing asid_generation to 2 and assigning ASIDs starting from
> min_asid.
>
> Consider two vCPUs from different VMs, vCPU-A pinned to CPU-X holding
> asid_generation=3D2 and ASID=3DN from before the hotplug event:
>
>   1. CPU-X goes offline and back online: asid_generation resets to 1,
>      next_asid =3D max_asid + 1.
>
>   2. One or more vCPUs migrate to CPU-X and call new_asid(), wrapping
>      the pool and consuming ASIDs starting from min_asid.  Eventually
>      vCPU-B from a different VM is assigned asid_generation=3D2, ASID=3DN
>      =E2=80=94 the same ASID that vCPU-A held before the hotplug.
>
>   3. vCPU-A enters pre_svm_run() on CPU-X: current_vmcb->cpu is
>      unchanged so the migration branch is skipped.  Its saved
>      asid_generation=3D2 matches sd->asid_generation=3D2, so the generati=
on
>      check silently passes and vCPU-A continues running with ASID=3DN =E2=
=80=94
>      the same ASID just freshly assigned to vCPU-B.
>
> Both vCPUs from different VMs now run on CPU-X with the same ASID,
> causing them to share NPT TLB entries and producing stale translations.
>
> The collision manifests as a KVM internal error (Suberror: 1, emulation
> failure).  The NPT page fault reports a faulting GPA far outside the
> VM's physical memory range =E2=80=94 a sign of stale TLB translations bei=
ng
> used.  KVM falls back to instruction emulation, which fails on
> FPU/XSave instructions (XRSTOR, STMXCSR) that the emulator does not
> implement.
>
> Fix this by incrementing asid_generation instead of resetting it to 1
> in svm_enable_virtualization_cpu().  On module load, asid_generation
> starts at 0 (memset) and the increment produces 1, identical to the
> old behaviour.  On subsequent hotplug cycles the generation advances
> beyond any value a vCPU previously observed on this CPU, so the
> generation check in pre_svm_run() reliably forces new_asid() on every
> vCPU after every hotplug cycle.
>
> Fixes: 774c47f1d78e ("[PATCH] KVM: cpu hotplug support")
> Reported-by: Chandrakanth Silveru <Chandrakanth.Silveru@amd.com>
> Tested-by: Srikanth Aithal <Srikanth.Aithal@amd.com>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
