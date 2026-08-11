Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948B93AE187
	for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469818; cv=none; b=J0vZywzNv574G+i6x4p43G1SnDeXzZIeGAdytF/vf6QutpVc2SAejzLtKZYyjunhjChve0WH4cijJobMfyieqVse3yzfVowfsSmdU+2kaAr56wTJcQeWN+s7JUyxto3iYmq+aQiQuSTZOXGZ/bItaphnVUt1RdGi9INTXHfUx0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469818; c=relaxed/simple;
	bh=HoEmxgbK/wtPn0Cayj/QuLhhlOz/pCLd2KRV41VuIzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jR91iGHEWvzjas9OiWWkCo6jAcEd73SL7EHkY4/9YZHRIDf2QkNV1m+sE3YadO/CRWw/3e62WdbEXCntNkmE/mK8YvrM/dx8f3+5xHby7C6UqnBddJPMCGpbktA8+KlW8lWyPP9RH/sOOYjeehF8N6kN6tmyDuOhVpBUQfm2nWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ogf9qnIZ; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ogf9qnIZ"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-ca6bd8a190cso55264a12.0
        for <kvm@vger.kernel.org>; Tue, 11 Aug 2026 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786469816; x=1787074616; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uJUp/BOYCSOq/Hvm932vFhS6A5T0Mt8edhLMmR3oVSU=;
        b=Ogf9qnIZJKcgPolJTzTv61fzgBdsf//xuCyzlormGNvqx0bdevyqDq4KBOwlg5Dj9F
         +eFMhKvHHIjluhLRD+5O0840HoFuZbmHIN9uZ/BHDhnZ1fzdEM+Qg1SvLKUnpGpYDaDP
         jt2li+fqXyVVLaWpPOUUF7w5kDIOE5/emblF9GQU9IwxMIbXHV3M6ekf4NKqRVDD6Ayw
         iwX+Ip6FSoNbL6c6jd+7YKq6BxCD0nNwlTGJ4oyXFh8m9AF8/p1vPy8DtFEMQe2d6KV3
         VCFpfzhmo9Ty3m0q1OY86+UM/OfKNPei6Dxe96D9lP99VowssUCBn607/5WM4mwdwc+g
         0Xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469816; x=1787074616;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uJUp/BOYCSOq/Hvm932vFhS6A5T0Mt8edhLMmR3oVSU=;
        b=ETEgMKs7v1sceuNrHlntzT+o5gBOPAmggyY4jtqqhFfYuWkdsb2P1KriAm9lAMsde9
         nZIpFY/PfAbwuvrqMGfYksIqOHVRXxrlUkgVoQRwO4vyv7XssR7zs/fm2SM8sTUTy9pd
         avSu+VtyOtdoBsEG3zsWBn/+Ul4P9LsiFu84UvNkW/GGcJrdnFDUi9QRzF/NpzI0L+Dh
         eeutwlZftPG7Ej1IscvvxtPQHajEZyshS9dOj0vFBYJT7OGOsYJbhWxMeiRgP8q/jlJs
         98vV2Ic2wH3X9XuiOp9C/gj6mf1bnFLrYGf6rYEx0OVDx/QrQhcBkm878Ai1xW70azuW
         jgVA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3y61m30poyGJL+4GKkFcw8KsMJedb+5JAaz93PPC6NmCspHqTRlpRx6B6idoN0ejJl2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx96r8/yHI2IcyxwZ5g1L47zj55W0lzoLS1vgUCp5IiKcLSe87D
	dcKkpou2oK2hzQWfgjfuvlLIZZDoeuiPfzgg4iIB+snE33IIrXSLx3krGnjyfq6va0BoM/A0Eb8
	ZN3/TzA==
X-Received: from pggr14.prod.google.com ([2002:a63:d90e:0:b0:c93:72f7:5d59])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9217:b0:3bf:5539:f93
 with SMTP id adf61e73a8af0-3cc2bbcdb17mr7184530637.38.1786469815484; Tue, 11
 Aug 2026 10:36:55 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:36:54 -0700
In-Reply-To: <30686bd2-37a4-4cff-82df-29c918444a58@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810112200.2326727-1-xiaoyao.li@intel.com>
 <20260810112200.2326727-3-xiaoyao.li@intel.com> <anpmxJOESl3swUpd@google.com> <30686bd2-37a4-4cff-82df-29c918444a58@intel.com>
Message-ID: <antdtqaEZz5EkZS2@google.com>
Subject: Re: [PATCH v2 2/3] KVM: TDX: Fix the exit reason handling
From: Sean Christopherson <seanjc@google.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Nikolay Borisov <nik.borisov@suse.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026, Xiaoyao Li wrote:
> On 8/11/2026 8:03 AM, Sean Christopherson wrote:
> > The shortlog is way too generic, and the changelog is light on details.=
  Over
> > the weekend, I managed to forget why this was necessary, and it took me=
 a few
> > seconds to recall why we need to avoid setting bits 31:16.  Of course, =
one could
> > argue that says as much about me as it does the shortlog+changelog...
> >=20
> > Oh, and shortlogs like "Fix the exit reason handling" sometimes lead to=
 amusing
> > follow-ups like "Really fix the exit reason handling".  Don't be that p=
erson :-)
> >=20
> > Something like:
> >=20
> >    KVM: TDX: Don't clobber exit_reason[31:16] when TDX-Module didn't tr=
y VM-Entry
>=20
> 1. It's not only about clobbering the exit_reason[31:16], but also about =
how
> to interpret the basic exit, e.g.. the change
>=20
> -	switch (exit_reason) {
> +	switch (exit_reason.basic) {

But the current TDX code doesn't care.  The switch in tdx_to_vmx_exit_reaso=
n()
operates on the raw vp_enter_ret value, not a synthesized/clobbered exit re=
ason.

And the switch in tdx_handle_exit() isn't reachable for the clobbering case
thanks to this check.

	if (unlikely(vp_enter_ret =3D=3D EXIT_REASON_EPT_MISCONFIG)) {
		KVM_BUG_ON(1, vcpu->kvm);
		return -EIO;
	}

I agree that not clobbering exit_reason[31:16] is useful for additional cle=
anups,
but that isn't the main motiviation for the patch.  The precision matters, =
because
it changes this patch from a "nice to have cleanup" to "this is 100% mandat=
ory to
enable Instruction Timeout VM-Exits on TDX".

> 2. It's not only about TDX module doesn't try VM entry, bus also about a
> valid VM exit after successful VM entry. This patch also preserves the
> exit_reason[31:16] for a valid VM exit. (One could argue that existing co=
de
> cannot clobber exit_reason[31=EF=BC=9B16] because the code to clobber it =
requires
> the [31:16] to be 0, because of switch (exit_reason))
>=20
> 3. For the case where TDX module doesn't try VM-Entry, I'm not sure if
> "clobber" is the correct word. There is no valid exit reason, so nothing =
to
> be really clobbered. Just don't synthesize a exit reason with non-zero bi=
t
> 31:16.
>=20
> My intent was just using one patch to handle them all, so as to make KVM
> behave correctly after enabling Bus Lock VM exit for TDX in the next patc=
h.
> Because they are targeted for stable kernels.
>=20
> What's your advice then? What do you think of spliting it into multiple s=
o
> that it's easier to write a shortlog and changelog for each one.

Heh, my advice is pretty much always the same: when in doubt, split.  Squas=
hing
patches together is trivial, disentangling changes after the fact is not.
