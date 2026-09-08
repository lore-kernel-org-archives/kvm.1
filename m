Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9963B3BFE
	for <kvm@vger.kernel.org>; Tue,  8 Sep 2026 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899420; cv=none; b=dpcGaYV4VQLPlg4NgAY95IoYydqoV9ZHMQI16XGr+DOA96zFxgWaitVr4ieqIVkt7uyxo5PBIAB3MuYo2zdoypqJGvavtbfRuEiRSdzMtWz29a43YFIesLlqMiwX8bjvmEJg+5PMntR4E0I5Nf+jL7ujMlSobJ40QFA0wPqZ+fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899420; c=relaxed/simple;
	bh=jTQZnRzWjpp4GM/Ttki5h3pn5ysANIAWli0RNBTWs8I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jdVuPVG+oa0igbYCemq9V1Tu4aybMlimzq7VQM8DVax+RE2Tm3oG11LZeLAfYCBRM1qA9801lgeAu5L1i4jGNFOKAZvGdfG8NG+jn6gaiAOKaoaH5fn6qx7uaS0KtCa7ch96rEgeRfLNrjRPi0ElKtugPmyk4QG46FPNWRE2fIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9mSNM5O; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9mSNM5O"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so1582885e9.3
        for <kvm@vger.kernel.org>; Tue, 08 Sep 2026 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788899417; x=1789504217; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/lPrjPHeCpuWaIstryQ35rUDg6akST866m/lT10o2oo=;
        b=Q9mSNM5ObMyZPpJITijn39mdWQqIWz54QDrFBj47s9dfjfJRbO13DUxeDPn9SSNuFl
         yDLNuE86/is0RvCSQUxpe/sayI6GL3NbuKf5h7DoLKYVtt7zdZXnV6b+zsXZRCBsBQgk
         zUB3TMX/tlkRsEfGPAGKv3mCL9T/n7nKjXTCHogdvM6Po20KhrFytXDu+nxg1jlVlrn7
         znt9wh4wiLI0aAtzIjS9FP27ls+DSyRMRiXElnRxZ3fnA7i53l8FQ2Qm729xEredh1SF
         PB6bZYjsM5k+UKFYkzz3EfsaYZG2le5fFYh/LhulO4crQJddkUBIajLxGAS7ZmVism6D
         wLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788899417; x=1789504217;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lPrjPHeCpuWaIstryQ35rUDg6akST866m/lT10o2oo=;
        b=Z2N66glZUydUN3/embYxczCMSsmBvUIOy8gLr5lwvssRhkDDvkpAa8sWLP64lsN/6L
         5xwrEYviv5BkmWQMKE+uuILtK5DoIrK87trhQqikhZo51t9Rawx6u0CBWjOT+A94s+Md
         BuNoBbZBTsKUivyNs0054Mr901MFgDbL73p9SV8ija1A/6dU+F8jVeDO7o2AZSlOXB1V
         CNXYgOWCz6b+HRY53wDLcxlzEhjpVvtbJ6IvFfhGCMc5jCFXFgRBYtCgewdTgECeCrv4
         k78jxGZEtrB50GUQ57tbML4bJfh+msPwjBeuh12VtS3srBNq/Uh8+8HzEWl0g1UjCds/
         f7cA==
X-Forwarded-Encrypted: i=1; AKwUvBwqz40cmSy39pwd2MvsFZY3OHaYnkutuxhd5SMffyHh0RnxYh3FaBWEQAvnzCFjJlgtxAY=@vger.kernel.org
X-Gm-Message-State: AFuF++lwOlgIIcyD7/Zuu5GVWn3AUWkVc7oZT9983ztnj7MuZ0sO5XzB
	tv7g+oD2wilnDVgcrTiOBnPfxVLwCUibE6JzPVpiEBCSmIKlmmKHJCdP
X-Gm-Gg: AYBFou0Rt+XAyOXhkNSl2InnUNLHsb0mOaYR7Mk41uJShZVzOyg2ro69N5FYDtxTtio
	mIdj1PD93rMDht0Ks4nSo/36qhV/8N909Pj1uGiX8v6IHomU3kHkxQa3FQql2ciGDkRHX0hjdMj
	X3UjkHvrFvR1DS5t0qEjrtAc13pSyQ3Z2gJAg6LCi96BAnOz+ZrQ86P7RE1cv0bOmZgNd3l50uo
	OffHFLMj03ajqlR9IvTlbFCzMnfEhFbq2Y4TBEdaW6n5a11eRF2Hzn2irZVaxWMFRgLXfc0K/8g
	rMPbd7k242oCa1/TjTRsnKlx1MP81y/68kYQQRyy1NnhYrsbHLMaEkMzR64PoqxDOZJxYrJ+2pn
	iW3RLfHI/HmDelKcKrg2gMrktmXiIuqPFOeXmVCjj3Xfh4qFEPXS7LeL4nWuz91v5Y1B0+fEmBH
	SevH0ReW5YqSk6i02ZPrPAmCZl1CIyCTtDSzacO7qLv+k39lvdG/RK31yDSpqFcg==
X-Received: by 2002:a05:600c:34c9:b0:49d:1deb:a629 with SMTP id 5b1f17b1804b1-49d1f21ae8dmr33294915e9.2.1788899416473;
        Tue, 08 Sep 2026 13:30:16 -0700 (PDT)
Received: from [10.245.244.96] ([192.198.151.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cff8195ffsm367067655e9.14.2026.09.08.13.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 13:30:15 -0700 (PDT)
Message-ID: <32b51faabf60f6e87d9fdebbf2c3fe5a45fbff1c.camel@gmail.com>
Subject: Re: [PATCH v3 0/4] KVM: TDX: Validate directly configurable CPUID
 bits
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org
Cc: seanjc@google.com, pbonzini@redhat.com, dave.hansen@linux.intel.com, 
	andrew.cooper3@citrix.com, nik.borisov@suse.com, kas@kernel.org, 
	rick.p.edgecombe@intel.com, xiaoyao.li@intel.com, chao.gao@intel.com
Date: Tue, 08 Sep 2026 23:30:13 +0300
In-Reply-To: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
References: <20260827031837.2863609-1-binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

**Disclaimer**: I am new to KVM and TDX, still learning, let me know if
some=C2=A0of my comments are off.

It took me several days digging through docs and code to understand what is
going on here, so let me summarize my understanding below and please correc=
t
me where I am wrong.

On Thu, 2026-08-27 at 11:18 +0800, Binbin Wu wrote:
> Hi,
>=20
> The purpose of this patch series is to prevent userspace from enabling
> host state clobbering features that KVM does not support for TDX.  A host
> state clobbering feature exposed on a new TDX module/platform can corrupt
> host state if KVM does not explicitly save and restore the related MSR(s)
> across host/guest transitions.  If such a feature is blindly exposed to
> and used by a TD, the host will behave unexpectedly.
>=20
> Except for a few fixed-1 bits required for basic TDX support, host state
> clobbering features are either directly configurable or gated by TD
> ATTRIBUTES/XFAM.  So an allowlist covering only the directly configurable
> CPUID bits, plus the corresponding filtering and validation, is sufficien=
t
> to serve the purpose while keeping the code footprint small.


So the general principle is:

- KVM is responsible for protecting the host state from being clobbered
  by the TD. Different approaches can be taken here.
  - Saving and restoring the host state within KVM itself.
  - For a subset of registers, relying on the TDX module to save and
    restore the host state.
  - Disallowing certain TD features altogether if they pose a risk to
    host state.
- TDX module is responsible for saving and restoring TD state.

We have 2 boundaries: VMM <-> TDX module and TDX module <-> TD. Only the
first one is relevant to host state clobbering.

Approach
=3D=3D=3D=3D=3D=3D=3D=3D
Your patch-set adds an explicit allowlist to KVM: a TD may only use a
feature if every register it needs is either saved/restored by KVM
itself, or is preserved across TDH.VP.ENTER by the TDX module or HW.

I think this approach is safe and sound: each feature is checked before
it is added to the allowlist. No surprises.

A CPU feature is associated with a group of registers, e.g. WAITPKG is
the IA32_UMWAIT_CONTROL MSR. So instead of trying to control individual
register access by TD, KVM controls which features are exposed to the
TD.

CPUID is the actual mechanism for turning CPU features on/off for a TD.
This patch works because the TDX module does not let a TD access the
registers behind a CPU feature unless that feature is exposed via the
virtual CPUID. An attempt to do so results in #UD or #GP.

Not every configurable CPUID field gates some registers, though. Some
are pure enumeration, e.g. family/model/stepping and cache parameters.

So the approach is for KVM to look at what features are enabled in the
virtualized CPUID, and reject the unsafe ones.

Details
=3D=3D=3D=3D=3D=3D=3D
TDX module enables TD features only at TD build time, via `TD_PARAMS`
structure of the `TDH.MNG.INIT` seamcall. This happens in the
KVM_TDX_INIT_VM ioctl, after which the feature set cannot be widened.
Migration cannot change them either: the `TDH.IMPORT.STATE.IMMUTABLE`
seamcall imports the source TD's configuration state as-is.

The virtual CPUID values are built based on what the TDX module
supports, what the host supports, and what userspace passed in via the
KVM_TDX_INIT_VM ioctl.

The ioctl carries 'ATTRIBUTES', 'XFAM', and 'CPUID_CONFIG', all fields
of 'TD_PARAMS'. ATTRIBUTES and XFAM turn features on/off and shape
CPUID, but KVM only allows bits it already knows about, so there is no
clobbering risk there.

CPUID_CONFIG is different: it lets userspace set CPUID leaf values
directly (but not for any CPUID, only for pieces of it the TDX module
allows, and KVM enumerates them via the KVM_TDX_CAPABILITIES ioctl).

That is the problematic part. KVM does not check its contents, beyond a
denylist that only filters out TSX and WAITPKG features. Everything
else is allowed.

So your patch-set basically kicks out the current denylist mechanism
and replaces it with an allowlist of directly configurable CPUID leaves
and bits.

There is a long list of CPUID pieces you allowed. I wanted to
acknowledge that it must have been quite an effort to go through all of
them and determine which ones are safe to allow.

Did I understand your work correctly?

> Expected host state clobbering behavior for TDX
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> We also want to call for discussions about the expected host state
> clobbering behavior for TDX here for future features.
>=20
> For a normal VMX guest, VM entry/exit behavior for a given piece of CPU
> state is architecturally defined: state is either switched by hardware vi=
a
> VMCS host/guest fields, or left as the guest value on VM exit and managed
> by KVM in software.
>=20
> For TDs, the host/guest transition goes through TDH.VP.ENTER, and what th=
e
> TDX module does with a given piece of host state is defined by the TDX
> module ABI rather than by the x86 architecture.

I think I found this contract: the TDH.VP.ENTER definition in the ABI
spec, section "CPU State Preservation Following a Successful TD Entry
and a TD Exit". It refers to a table that lists the MSRs whose value
may not be preserved across TD entry and exit, with the condition for
each, e.g.

  IA32_PL0_SSP         Init(XFAM[11] | XFAM[12])
  IA32_UMWAIT_CONTROL  Init(virt. CPUID(7,0).ECX[5])

This is from an older version of the TDX ABI specification. I could not
find 'msr_preservation.pdf' published. But I assume it is published.

Anyway, seems to be a clear contract to me.

>=20
> What we would like to align on is the expected baseline behavior of
> TDH.VP.ENTER for future features.  The proposal is to have TDX simply
> match VMX behavior, i.e. on return from TDH.VP.ENTER, state that VMX woul=
d
> restore from the VMCS host fields is restored, and state that VMX would
> leave as the guest value is clobbered.  That keeps a single model for VMM=
,
> and means enabling a new feature for TDs requires the same work flow as
> enabling it for VMX.

Let me restate this to check I follow.

For a VMX guest, it is the VMCS host-state area that is used for
restoring host state. KVM writes it in advance, hardware restores it
upon VM exit.

Most of it is loaded unconditionally: control registers, RSP, RIP,
SYSENTER MSRs and some more. But there are some MSRs that
are restored only if KVM configures the corresponding control bits.
Example: IA32_PAT, IA32_EFER. If the control is clear, the MSR keeps
the guest value upon VM exit.

In KVM some of those controls are set once, e.g. for IA32_PAT. Others
are toggled at run time, e.g. "load IA32_EFER" and "load
IA32_PERF_GLOBAL_CTRL". So there is dynamicity there.

So the proposal is that TDH.VP.ENTER should draw the same line: whatever
VMX would reload from the host-state area is preserved, whatever VMX
leaves as the guest value is clobbered and KVM handles it. Is that
right?

So with TDX module there is a twist. First of all, my understanding is
that the SEAM VMCS (which controls VMM <-> TDX module state
save/restore) is configured when the TDX module is loaded and stays
fixed after that. So no dynamicity there.

Second, the SDM says SEAMCALL behaves like an SMM VM exit and SEAMRET
like a VM entry returning from SMM (SDM 35.1.1, 35.1.2), and SMM VM
exits save state into the guest-state area (SDM 34.15.2.2).

For reference: An SMM VM exit is a VM exit that begins outside SMM
and that ends in SMM.

So if I understand correctly, for VMM <-> TDX module switches, the
hardware uses the VMCS guest-state area, not the host-state area.
Not like in VMX guest case. On TDH.VP.ENTER it saves the VMM state
to the guest-state area, and on return it restores the VMM state.

IOW, looks like there may be significant differences between the VMM
<-> TDX module state handling and VMX VM entries and exits.

So maybe the way to go is to just follow 'msr_preservation.pdf' and
adjust the allowlist? I find this approach safe and acceptable.

Artem.
