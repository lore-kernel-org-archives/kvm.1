Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795124474;
	b=uVv58tjoNb48VZhC0jgzWBucBSD2rO12j9WQZ2Ws0Ql0916W6cX5LSXXPMIBLrE8PKSr
	 pFFOA9OODisJ01yJwmV7fBQ9hYv6EW/0Fr++vPQVl+Cl8muReOdSUh/nulCmzjFDicciR
	 2N0ml/kh8aiYPY1uDtYN1XIJmevp6wa32B8KTzBRWuAoZkxTkDu/7pyvPizfsaN/XinIu
	 anW1DnN7tnUHrpQ1nwIC+fc5uvO1pH0j2Ygw7tTh5BvVvEL5gg8R2SI4HBOCxwuEOS71e
	 to/XUqBO+QtTexnorI4NhXXKEb5D5deptBVk5iEOGof/kFX0t5RcLSotQ70UWpkV1wg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kDU29mIYVbX6MgdkOf8i59+de2UC///eq4pVelmEHVw=;
	b=YLQn9MYa421a4Q/LM7rYycirL8jiEtKBMM4dwX05R20Dj28+/60c9N2lh+CTW/U24N2Q
	 IyT7McmVHyzqTMGpe0Y4f/IzHU5a7B7pgUdmIic2UmGwpYIuojK7SMf84IRXRlMCnvE9v
	 PLl0+BVjyo+EyiyvWwhYL6phlDG5TayZsg50ZO/7zgu+DXTtPmPYe8IzMC3VI6YAwmacT
	 hUuSsaSmnf4CRkOixTWKoyVnJNvNt/IlbM3MKTFnpuaZhY/x0ZF6GYouodXCVW9i0DOTT
	 O2Gg3keKEpDL00pGAu2O5/pUS9E2naHA8lPgiWOz43jlolq0XQWSUL4P+ef094lCOSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ilDK/JZ3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466C606A320
	for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 21:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1466C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ilDK/JZ3
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6ba2bd43dd8so1179a12.1
        for <kvm@vger.kernel.org>; Thu, 19 Nov 2026 13:41:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795124472; cv=none;
        d=google.com; s=arc-20260327;
        b=HONUAPD6BxTK7IED34D5WWG86UbN18zzEMR79d/Yrwsi96rdVmaoKLGiVSnz2JJbw7
         K933p31ZRk6RyWn7zZqkEukph4SwZgA6gu/+Jq/tqxkQCmv+vUbwLZEfN7iKG5Ct8Q1W
         kT1d264pF6CmZj2/5dXiViD4OnouuT9TCqr4pss/AFXJuRk7OLcRBLiKhF783lZ2bhYR
         yYrat1T1YKSK1UOGxgFuOX+kCKZVtdQep0Kfyz0UA13QgSoPRqeJa9LrY1A5FDuFxlHT
         D0elmJSK3beZEMIc5PAk6bIxbAHi7hBGQa2WZJgCvm5deexiYELPIe4vqd0ZUM3tw9sH
         xiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDU29mIYVbX6MgdkOf8i59+de2UC///eq4pVelmEHVw=;
        fh=8MOZO32Hxws3fULCY+47eI8AaGhCuD/yWlwxLk8+6G0=;
        b=AikHfWkPbJFkaoRtPmCCls3nPEXtriyzLK8BeIVZkTpIBnGfeIS0YpOoLW2Nq+w9yF
         h89JupEcfAHMU93giRZvwseXDfen9TxoJ8FyYAdq66LACvB11KENftsd9+yXQxZNTIRL
         7wrhi5pv3KHib32ufUVCxP3fapkDljnPbPfoleonguZqzY+/nYxTN6Vyka1awv786bL+
         8dLA9Df33BM5aVWiV85UNN2oXz7NKCAKO0WIYY/XG9U/16YIRlKQ7JS1SKE3qHQWjm28
         YerYfXlrVSw3APJn9Qzpb5t6HeM/lV8OmtiawwFaLyOPCO393FcuBmHI10ASAVghGnm4
         msaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795124472; x=1795729272; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kDU29mIYVbX6MgdkOf8i59+de2UC///eq4pVelmEHVw=;
        b=ilDK/JZ3iEhPmA6fqX2i/BpAabmE/voFmCJTFAAWDESlKgB9pllQ1/l/7DVqZwMCw7
         Y8zmPO55IGLBEUXYzWQH7MdJiWX3yMBo7hKFNqbIEt68RSsqm/x/F5a7dVSbXx/SH1Wo
         Z8IFTE3EWw7O2v79rIXjKXJ2lEjmomWf2JtoRmDd/Cw+lS5/IApS8BSVyacoha2cvfmq
         d/eB1nOn/1xJ2os1IfAsQF3HQNCpIGycC6f0PGvBINo4pbI6lzYsB1hA4s2oIvUfevk2
         lBzsn2Ii3sXcUB8pKB9gaIlFAWNXC1awm1Z1gic3HdwP46Awc1xnJih4wTGbYbc6UFoQ
         tX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795124472; x=1795729272;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDU29mIYVbX6MgdkOf8i59+de2UC///eq4pVelmEHVw=;
        b=1eJWmelAlrGqroDcnZIoEbhtvk4KW+fjNOk2vBYzLLSGvORRpDE8FVpqpihHQahMyB
         YavOXwc5FPdgTR5Ut7REzM5dlmx90w7KjpAErPuhwoD5UswefmIsOEIlYCUl2KRzCWCE
         c8NolpLSvxzMtfmt9tEonsCjkSNaPlPQbWOygjTYDAMfugx2HTBatFT9resdtXxFST4q
         BC5TqHqzHs2BCifUlFJfAkN7eWXt/kS9qAknfkDwY1W1LW1HELxweWe2GNvNysAF01rM
         bwd8qs7Owpao7JmrDGYej7gSTE3tjxV5JstZ4w/vhEwXkfy9EDu392dX6jU1R5s7R4tv
         svNQ==
X-Forwarded-Encrypted: i=1; AL+hErHckeXlN4IHV2guRsg8aMh/DIVRTgRGEkITNB7fGKCt6ibOsUxZSSeU9IIrw1mFLibKWGw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+m+RyUPBGWv/n9dKoT46QwvYCgsJnDElp61eLSd09w31MSgE/L
	domEUYqeLbQA0rtWVLFcO73VwZSPusdyd61jnL8HS+xLppdegPgcPNEWNDAxWzl0k071ML3wUtk
	OfhqfYZENqDGlCf3TFyfKt82kPpkBKegkn860k7wt
X-Gm-Gg: AYBFou1m48mcI/VFBlmYruElxaPZgdM+JsxW9kTjuRG9kQkPoebf1nGuY7ReqaQuYF7
	O+KIdErz1JOFYrk+MCiRmtslnxPEUH5xM/jC3OteQu7NdMb6Dr+rE0n78rQ+wqum5zRk4Dv4Qat
	ruhjDG+j/6Ydl/8rUHWNd2SZckr9K9FFJoh+rMXtAJ46CuesFNUMfBly5ogEpibd69REROmucX3
	fu5b4hyqd7QKC7EoAbn143Q2B6od+Pu4vnHM2SrgS42JwHAUtbZMMInjQdsdhOZL7Oi/4aga9Iy
	zqpfR5tzWLjXihbwn5bubV5Q022nqVlevmcBwDfeB2X5v5RQ1/JDn+2aQQSUhZZdalHNGSw0ZsF
	NQzaeiRk3F/TN287ADaze/XOIJJSEU5TTCMxgx/IEc8Bbo00XIZ78w8yKJyjYHNNXJAtUuU+MLv
	THWUr/Nl2+Iq2gDjELVGnxy2jDSoiQqJ7PA6foa9aae5SuR045JkD3fg==
X-Received: by 2002:a05:6402:a218:10b0:6b1:a517:5bce with SMTP id
 4fb4d7f45d1cf-6ba3f5dcb39mr6485a12.16.1795124471909; Thu, 19 Nov 2026
 13:41:11 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com>
 <CALMp9eRS8Pg1E76yeFYd5Cq6O9EGcj3LMLV4X6-54ozFamsNsA@mail.gmail.com> <3ff9ea37-f70f-41a2-be3a-0af2c68c48b3@amd.com>
In-Reply-To: <3ff9ea37-f70f-41a2-be3a-0af2c68c48b3@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 19 Nov 2026 13:40:59 -0800
X-Gm-Features: AclHuK-THxc7myE4vHruM5DxsNF8cnuQUt6G9cD5Y2L_LD4SkB6Kg2nWoFGflwY
Message-ID: <CALMp9eQ7a4tgH7DGdPZDE+xwie5c7DvvP66FbVM3wMPBJKZRmQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] KVM: SVM: Add support for AMD LBR Extension v2
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 12:33=E2=80=AFPM Shivansh Dhiman
<shivansh.dhiman@amd.com> wrote:
>
>
>
> On 21-10-26 00:53, Jim Mattson wrote:
> > On Mon, Oct 19, 2026 at 2:06=E2=80=AFPM Shivansh Dhiman <shivansh.dhima=
n@amd.com> wrote:
> >>
> >> This series adds SVM support for virtualizing AMD's Last Branch Record
> >> Extension Version 2 (LbrExtV2) in KVM.
> >>
> >> Background
> >> ----------
> >> LbrExtV2, introduced on Zen 4, is a branch sampling facility. It recor=
ds
> >> the last taken branches in a 16-entry stack of dedicated MSRs:
> >>   * MSR 0xC000010E - Last Branch Stack Select  (LBR_SELECT)
> >>   * MSR 0xC000010F - Debug Extension Control   (DBG_EXTN_CFG)
> >>   * MSR 0xC0010300..0xC001031F - 16 LBR FROM/TO MSR pairs
> >>
> >> AMD hardware extends the VMCB save area with fields for these MSRs. Wh=
en
> >> V_LBR (VMCB.MISC_CTL2.LBR_VIRTUALIZATION_ENABLE) is set, the CPU saves
> >> and restores the guest's LbrExtV2 state on VMRUN/#VMEXIT. Thus, the
> >> guest can use LBRv2 without interception.
> >
> > Only DebugExtnCtl is actually swapped. APM vol. 2 (rev. 3.45), section
> > 15.23.1, says:
> >
> >> VMRUN only restores the guest state and #VMEXIT only saves the guest s=
tate of the LastBranchStackFromIp, LastBranchStackToIp and LastBranchStackS=
elect MSRs.
> >
> > That is, the host's LBR stack and LBR_SELECT are simply lost on VMRUN,
> > and the CPU doesn't put them back on #VMEXIT.
> >
> > Isn't this already a problem today, before this series?
> >
> > At the base commit, KVM sets V_LBR whenever the guest sets
> > DEBUGCTL.LBR or DEBUGCTL.BUS_LOCK_DETECT, for vmcb02 whenever L1 sets
> > V_LBR in vmcb12, and for all SEV-ES and SNP guests.
> >
> > Since KVM knows nothing (yet) about the LBR stack fields in the VMCB,
> > they are all zero. So, on Zen4 and later, a VMRUN with V_LBR set wipes
> > out the LBR stack of an active host perf session and clears
> > LBR_SELECT. DebugExtnCtl *is* restored on #VMEXIT, so the host resumes
> > recording, but with no history and no hardware branch filter until
> > perf next gets around to calling amd_pmu_lbr_enable_all().
> >
> > AFAICT, this series doesn't address that issue.
>
> For the new LBRv2 support, my understanding is that the mediated PMU
> restores the host state. KVM exposes LbrExtV2 only with the mediated
> PMU. After each #VMEXIT, perf_put_guest_context() schedules the host PMU
> context in again. For an active host LBR event, this runs
> amd_pmu_lbr_enable_all(), which writes LBR_SELECT and sets LBRV2EN
> again. Thus, the host filter is back, and the host LBR stack starts
> empty, as after a host context switch.
>
> Is this correct, or am I missing something here?

My comment was about a pre-existing bug. When the mediated PMU is *not* in
use, perf_load_guest_context() and perf_put_guest_context() are never
called. Yet KVM still sets V_LBR whenever (a) the guest sets DEBUGCTL.LBR,
(b) the guest sets DEBUGCTL.BUS_LOCK_DETECT, (c) L1 sets V_LBR in vmcb12,
and (d) for all SEV-ES and SNP guests. On Zen 4 and later, VMRUN with V_LBR
set wipes out the host's LBR stack and zeroes LBR_SELECT, and #VMEXIT
re-enables host recording via DebugExtnCtl with LBR_SELECT=3D0.
