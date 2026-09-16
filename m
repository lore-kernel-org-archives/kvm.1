Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386C037F005
	for <kvm@vger.kernel.org>; Wed, 16 Sep 2026 02:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525557; cv=pass; b=JPgIAe8UkfYeWJ4rfOIRTvs8CSvp6KfgNLlg065WSLHbawyYi76DNEasyomOscT9eBnuuuQmqqOwIlBQ5T2q1SrU9iVWUZvWCbXeJrCfvHH1jQazOKyIwMfSBORocHbwDWR5nJJX45b13GJFER2An0wKs+KS+Q9yf8RWQfnrxVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525557; c=relaxed/simple;
	bh=UbHdjXh+CgiQpvJHaSyIzPDW6diIJy69tmAGod3Q4Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXgYWmBN+MCpfS7DnWc9mHFGgFkopTTaGQBlJTLd3ElJRL1AVVRi/L7aMximQlli1AgMNJtaDgGJAriUnJuqi3y2/jdCxEEIbZvaWP2AG230kTEpLGo95b9G2zJ4/gn6hc5S4Y05E+7jHFdQkNyCeK4b+1IaGMbi9qDdDFBeYAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cq39CDHZ; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cq39CDHZ"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6141a61c0so3137a12.1
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 19:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789525550; cv=none;
        d=google.com; s=arc-20260327;
        b=oUli2txjfl8BJBUDTXlc691zN2Kfn5iFUCzYDN9nYf5KplMrmochs5Hg1u5qS9I3Vw
         W4XIswxTVE0bdKe7g+aWtF8GJ1aLdf8ox1AErfgtUkDkikb/rZmcGGsp2iRP+MjKGeJK
         uKahLwfCknIF/4neEgwBxmwe8n/EiG2fa+REIrU6VuvjOLQPxk3wDMNDw+vCbdMhWyQ0
         Nen9yW82wqyy8nM4cWYJuUpOkHuSYDE/izy/ZkHKIIzwaOUpDUHzIAaHGPzGAa9Os4Ce
         7ffWXAC2ddU8/Pb6KJRZ5sLapO5wH/UisY9yCjVYND54jTsE3v/NxH8Ni469g4/C3Bvw
         PLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z4v5CneiAAJU37Ea93Bpgw0r+62LGWh/ZxCVYmbedPc=;
        fh=FvqW3rARLRNFwc9bzxqUk7fXzLZGvJ0DlKCyIEdzRhI=;
        b=RJalRcVpKsy+ItrNjzh/YatAFwpBbkoj6CAswzLBQnWm7tALYkISDuKl/IxWELmUun
         p/68J4SMX24U7rzeQJnV9StfJhE2wYwft73qlBPVR+5Qg6mQ0BUwLN+Ti/I5g229jpVN
         DNAkaupXboNvsJgpbwtQ//Y1GwQnB8ZF5YMu7uIzxZFgqlTYBsnPQX3luL99Sd0e9maS
         PjJFM/UjlRBwAoeXSopPUkrv1tKnjRvbptt1HNLXDc3gjE4TgRGK2+b+ttUk6m5O1Ymi
         hwgyuEFsBiXHSWKpjkzm5KvCNU90jXbROhUPbipZiLt0iqrhrX0+rd7pDjdFI6GGdKhd
         lQIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789525550; x=1790130350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z4v5CneiAAJU37Ea93Bpgw0r+62LGWh/ZxCVYmbedPc=;
        b=cq39CDHZeCOjj01TE2PhxjSEFjeOC90/0XKd+diB3w98/mdpj237mhKHvGyx4A16AJ
         f0twhaguAexhyvY3jdADqR3ojwNQJA3qjrYuFGxWExYxaMDK3b9Ped39a0nEUuqlgL5l
         ik6WKCGQg/RaGNyX+cxbQ58xlkZFmCh5MIibe7DH20mKXQloWRciN9J4HF19FwR+OtZR
         B8AnYumEuOEEp2toTXVpdm6vHYWc/8wnlFasoETZWr8KIjV2CagsdMsz69XULM+VbCwN
         H4zUTKYBz860u8JbOjSsNcFWtaRZaTXkEAt6R3yqT7Q/vqu0EYu4abeaOQJDCsU84bZ2
         wtyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789525550; x=1790130350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z4v5CneiAAJU37Ea93Bpgw0r+62LGWh/ZxCVYmbedPc=;
        b=VXh7aLC4rE4farq9Jg29K51eSxL+ftSSEOyWZ02aWrcAE8O7PSUYcugTYnIN6WPkxg
         RAqEA6FQu8R7qPhVMAdjeZ8rvAELjuF1aZRNWHe9xmhLxQnqC9K010hdreIEHyjKwPpI
         JDLx/UvdgjhUofFyi6yXEc4wOp03+mVg1mr9ut5LtI0DvqVgNbBWsGncSTlCky1eTLei
         t8cCGQsCNMftsErfw/X0A34QxY317sBxhzoQ9+Q3/C//pqD/uKzm7BOJaRYrWuC4s1mb
         u8p/55a1fFseZYlYGHlZeWHGxMs2V8mtXb7rbxtaTfpJzG6X9AgsYfc2WF6gK1QtxRo2
         5VHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcmjXqHZtIVSRxcwvb6cw2cznVItCEaJmLCR1qOU3jqVBxF0riyGK6gEc4pIg1GsPLl7A=@vger.kernel.org
X-Gm-Message-State: AFuF++n1c13ygalLKlD2yOGR5eq06BEVLKe92ratTVkgEWvyWe63RNT+
	oycCh5d7oLdUGt/aQy6t+BVt8ac/zFq5+7q2ir0UV/bYyIfdhmgt5H8LQEfNR4TkGkeNSlTOqG7
	NdU8EvuF1st1PiGQ7/6x5kBGWrt7TvHPNR5gfcCA=
X-Gm-Gg: AYBFou1yS6MILHN+pAAGE8a/YqKztk91+722fNzy1IW+x8dgV4jOtpnH/9W0fjfgME2
	TDU7SNn81/ug+sYRrfRTh+8UtOoAmaSOc69N+SVFtjo1LesNcHlhWxUi5m3uPtXtr9dZ9TE+9mT
	/owEjRzPiuUh577mgFfGWnlKFCIcet0pK8byx947kZBTPZNeo6fSVB0KsJx79vcVqmtZSFpwQzx
	lnZmMMvTj2e1Vj2KsLAn/kl1BPjCUiS28VWdzUpWI3pflay/Noj3xUdnPzUvdMj6SrOUZK5txTY
	8ErfNY385iq2FA4UlX0b1Lxu98Nb7TDhQAqGQvpwq8ZMQ4wQDDBkmXjYCVhkseh+Ge+gTvMS9JR
	pWsduOssuaQ==
X-Received: by 2002:a05:6402:a204:10b0:69c:39f5:7e36 with SMTP id
 4fb4d7f45d1cf-6aa2242dc9dmr11519a12.0.1789525550214; Tue, 15 Sep 2026
 19:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-snp-invalid-input-v1-1-fb2e03da614b@google.com>
 <0b2d8858-b361-4a64-986a-4c179210fbec@amd.com> <aqlWt4jb4CSPnecN@google.com> <d6179d34-a4b0-4548-8298-b790b333d22f@amd.com>
In-Reply-To: <d6179d34-a4b0-4548-8298-b790b333d22f@amd.com>
From: Jacky Li <jackyli@google.com>
Date: Tue, 15 Sep 2026 19:25:38 -0700
X-Gm-Features: AcwNN1XSdLAmVMpNGhlhvJVsI8al7B9K_71Imap5Z5_uyW4qm1svC0PFF6S2QLo
Message-ID: <CAJxe5ctcVxmhRSw3Gt0POQTzRKoxXo7+Y3CPDe7cUZvC0QPK+g@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: Return INVALID_INPUT on SNP req/resp buffer
 access failure
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Jacob Xu <jacobhxu@google.com>, 
	Supraja Sridhara <suprajasri@google.com>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 8:21=E2=80=AFAM Tom Lendacky <thomas.lendacky@amd.c=
om> wrote:
>
> On 9/15/26 09:31, Sean Christopherson wrote:
> > What if we keep this one as -EIO (or better, change it to -EFAULT in a =
separate
> > patch?), but add a comment explaning why KVM needs to exit to userspace=
 in this
> > particular case?  That would be a good compromise; if the guest is atte=
mpting to
> > access non-existent memory, the initial READ will fail, i.e. we still g=
et most
> > of the behavior Jacky wants.  The only fatal case would be where either=
 userspace
> > really did screw up, or the guest managed to find read-only memory (tho=
ugh I
> > would probably argue that's likely also a userspace bug?).
>
> That sounds good to me.

Thinking through the sequence number and VMM bug concerns, I'd still argue
that returning INVALID_INPUT on kvm_write_guest() failure is preferable to
exiting to userspace:

1. req_gpa and resp_gpa are two independent guest inputs, so a guest can pa=
ss
   a valid req_gpa and a resp_gpa that isn't backed by any memslot to sail
   through the initial read and fail only on the write.  Exiting to userspa=
ce
   on write failure therefore still lets a guest kill the VM at will.

2. Comparing the two outcomes after a kvm_write_guest() failure:

   - Case 1 (exit to userspace with -EFAULT/-EIO): unrecoverable.  The PSP'=
s
     response is lost, and userspace can't rewind the PSP's sequence number=
,
     so retrying KVM_RUN would just fail that check.  There is nothing
     userspace can do other than kill the VM.

   - Case 2 (return INVALID_INPUT to the guest): the guest disables the VMP=
CK
     and moves on to the next one, as Tom mentioned.  The worst case, once =
all
     four VMPCKs are exhausted, is that the guest can no longer issue guest
     requests, but the VM keeps running.

   Neither is ideal, but Case 2 seems to be better: a localized loss of
   functionality instead of the entire VM dying over a single bad request.
   It also leaves the decision to the guest, which can carry on with whatev=
er
   doesn't depend on attestation, wind down cleanly, and shut itself down o=
n
   its own terms instead of being killed abruptly.

3. More generally, when KVM can't tell a guest error apart from a VMM bug a=
t a
   hypercall boundary, reporting the error to the guest seems to be the saf=
er
   default: failing the guest request degrades one service while keeping th=
e
   VM alive and debuggable, whereas exiting to userspace turns a single fai=
led
   request into a dead VM, and hands an untrusted guest a way to terminate =
it.

   And in the context of SNP the guest doesn't trust the VMM anyway, so a V=
MM
   that fails to deliver a response is indistinguishable from one that refu=
ses
   to, and the guest already deals with that by disabling the VMPCK on a
   VMGEXIT error.  Letting a host problem bleed into the guest is arguably
   "fine" here, since the guest is designed to cope with it regardless.
