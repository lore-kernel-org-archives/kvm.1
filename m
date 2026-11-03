Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793666071;
	b=SsfqcLvstfb2WC1vX1G+jAm+nFXrhpJk+SrfBtvsN0d0BTjz/1mXV0t1KLSZPYXBoYXE
	 G2OAF6o5wTOkTYrPzCcDxXwCAz3JOZnbcVX96b07oSbvceYC2kwqtcNIQrOfFhzTKz84v
	 I41/V2fYAO5UFR1ygb4USSmvZx49wwZ292bfXGLW4jcrX6C50LvBynBCbDTJV7mx9OEme
	 sY4ws8J39VbE+UbU/LZA4ZG56xXCWWmaE6k9e6YuXnIAKt3mILHXT4HpxeDECz/LpNE7w
	 1epuxS5DSQcJgv/wrV/MoEGPgg49FHdn8aNXoXVYfrxG1CJpERDMpX4jhHjXVc6ITWA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PxTAxfsu2xujpRsZKIGjHiKUrduvY4qnImh+uidz1a0=;
	b=j7mR7bvLYV78nwhn89KY+2S4DqWul/Htk3xQTFqSC14IOtp/JDtpdzemR+MIWLeYSsEf
	 wYr4zWWGV04xWRQsRjzWbZmQ4R5wcfeUECsBLb091h8YWCf7kuNyRPUprmYJZR69wse68
	 AaY/1tdVoSSW8yS+uv+PV7lfJnh1/iQttYVc5q4ee+ojFxrwjVF6TdSAnDTTYUVPjOSr2
	 MEUJgG3ffXz418upPv8Rtu8QYasGIDyiRbco9hl3d0acS9b1qSFLXqfojtl4M+zG4UXhP
	 cZdbZQNm43drrCM4bn1g1HS0B1MQ/aXMrH/L96c4hje7N6tK3+E7esGrITNvfp1iB7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cN0iJRAU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54408606A329
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 00:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54408606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cN0iJRAU
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso4308a12.0
        for <kvm@vger.kernel.org>; Mon, 02 Nov 2026 16:34:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793666070; cv=none;
        d=google.com; s=arc-20260327;
        b=FApbqIZ0aPKFKLdWsZSrT2h8a+qw/FFy9+8+WnDCSogSMt4zKvYkD492SPWVKA6YSe
         IXWaDNKCIiWwQiXbpCUEaQx91GT+ps1ZR0EKRNJVjeO/UbePumTliLO0E8ZEsVouwQCX
         Q2H7TA3aLj+rnfJBTzyBfOj7GkdNZR5Mi2N8vbJK8x06fQaH+dyVc/fTn/xAraDgTldL
         eY0UgvcZmjcUAQpta/vaq1jRibZxsZhX9rPkh4/pHP1V3of7gAOm5bJj18v9orTYSdYJ
         KdFuYDVfH6F+al9bItPjpZ2No4muhr9E9U/ThM3wrrJcmk74jGVoBT0mIVa0yCxmxO9H
         aheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PxTAxfsu2xujpRsZKIGjHiKUrduvY4qnImh+uidz1a0=;
        fh=ami7ofpxnydzomgMd4Pd1Ef4jnBRuiKyZxJiUyvAMSk=;
        b=R/GFfpvQHi+RLOZxQi69d/u3o1nFhJ3LouONddzc76X0dTsbgdd5hUOarTzblmD6Ua
         96NFF0SxVSVZVhVoxeJMnx35qpC9GqO4YMXn6gs+clItLe18Y7zO88MMuOf0UPE/czZC
         be4xujD1HSAa/Cji9xhnPdsjpqBS/xJZACiK+QgrMre9e70A3jDnuSlj2ndPLwby7UKG
         HCjzvbJdJIJ892Tw0zDv6jdL75bC3zmxCDH3tYZCJH1FXNLW5EFS3kHJ/2/xvdaqS/41
         WTG0AL7EiKz0hIQMVDQsTFHiHunuH+L/qfX1HB1Ycdp6y0yOAIph3nx7tsAOmnV/nQ8r
         BLKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793666070; x=1794270870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PxTAxfsu2xujpRsZKIGjHiKUrduvY4qnImh+uidz1a0=;
        b=cN0iJRAUZTWFJPu2xP47AzsFQwwDHlwRCp7tiGw9UzXTtd188TpuktVfe6W+9lNWhV
         g+jnzckczYT/wyawEqJc5CL/by6p42E1nf0netC4eThk9nE2yVcHZE4D5kd9k/ZAxaoI
         R/hSnb2l0ZoSQVN4zpSVfl7FfSUqMvI/1bndhyA6/R42v8QooZU6mwhlJzBBGKvwp1Xw
         4YN8Z0uBLqNu/pp0DcMrFF+k+KTqx+i7jJ7z5qhlb3805snE/lZU03LjQEcEOC6OMopk
         3MSrgral6YurjGusBMxiFnhAI8gp3gxYzKC+57v7xz9WaaPXN7Nmn9kf6Qs9bwrouIqo
         9uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793666070; x=1794270870;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PxTAxfsu2xujpRsZKIGjHiKUrduvY4qnImh+uidz1a0=;
        b=VhEwPItMKpLkU6qCrqNaU44Hi/I8zC+NHIi0O7QQVyRE5UGXouHblaU6YToPQ5EUXb
         Z5dLQZoOlCqoHXA6ezFZWAT0NUSEzvBZDOvA0jv3fOUZHOGS2v7wXhSstgyTpBxWGV4v
         L9L90mPQvUkCkku8GgEw09dfu0mAQ/iSgdHdcJuNNHfIt15ytG1PxtDimHwS3nCx2ec8
         L5O/wTPoz8WdShqs6+/jNEyds1HkpuMISwS6XNZfL18ccIrNYOtdn6akDw3z2OZ+Irw7
         VtYZRl3z/1kWGJpTatHj/Eu8U+1xKnyNXtbTrni+JGAH+bLmho9OKl+Qm3a/25GtuSy4
         JVUA==
X-Forwarded-Encrypted: i=1; AKwUvBxfN1iGYkRUV2DKhWOK0qnUoxd81ZAxuGeSc7U4wT+F8jF0rQLD0oGybGRG83zwRCqRY6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TnIbFuvp4Ss3FWwNU00Pv2DBMuAfbrdtdGb8Ew9Sz/QF6Ow+N
	LrRmk1ePTMJBdueFEDj6u7dFsemxMnfZaTR1IL0h5FYqlsNo7sCl+kB+KGCU9evWi56pVuUb6EK
	ZMMP+w+h2q049GyHAzwo+j8ptMowMVa6jqmADi6Dl
X-Gm-Gg: AYBFou3mXUGjCQjkRT0CZ6lhjuoXp8pKJVM6DH78tZE6FDcgp1aHurho7DUiwCHOUH5
	S6jLYes364vDKFk2aukqyQSkX2RZ2acpeLdkcWvqe5hea8+czTkLR7F6uHvq1KA1OqkLaQBVtRo
	Ccf8Z2Xfa097o0VQ7GYZaS0CQbnBbBEhk0DZfpc7LkiQ5rIGXnmrf/Ns4Xkj4VQNzm9rRhOYh6O
	czjQ91PPndQ+IZI2mDawND73kl9eaJvuC8UJBcMqMHOOJL0W+xyf1AbCn3Pl0hVGyxj6XrVnbPn
	0bIZvgXcyDXpagtDMwwPW/YMza0MsZE8IkaQDVAJiwXVl1dUw+zUuF7ic0MZLQ0pzYFDsXWheBO
	50vK0GbWJ33zeFyI+yD+IyCDGkaUpCEJ1+xnZUwCfZrKx2IGfCfDP7t5auA==
X-Received: by 2002:a05:6402:23c6:b0:6b1:d80d:396b with SMTP id
 4fb4d7f45d1cf-6b53e99397bmr14504a12.14.1793666069308; Mon, 02 Nov 2026
 16:34:29 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102231428.13523-1-pbonzini@redhat.com> <20261102231428.13523-5-pbonzini@redhat.com>
 <CALMp9eT7cnBf6kSXZLWuMyG9a52QveWjzzLz3Z9E=kPuX_ahVg@mail.gmail.com> <aukmeb9mV8b504T6@google.com>
In-Reply-To: <aukmeb9mV8b504T6@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 2 Nov 2026 16:34:17 -0800
X-Gm-Features: AclHuK-5rtlAEwRRycyUXrlFAmgT2tBIF1kZJbMFG50_yS4OyXqjAn6qnB5u6Ck
Message-ID: <CALMp9eTm1GfVTSCroWNXi_jeGcnEg7AfxEhcqJyN4s_v-PWcmg@mail.gmail.com>
Subject: Re: [PATCH 4/7] KVM: nVMX: Process each host MSR entry at most once
 when unwinding failed VM-Entry
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	stable@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 4:10=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Mon, Nov 02, 2026, Jim Mattson wrote:
> > On Mon, Nov 2, 2026 at 3:19=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
> > >
> > > From: Sean Christopherson <seanjc@google.com>
> > >
> > > Add a missing "break" in the inner for-loop of the open coded mess th=
at
> > > unwinds MSRs back to the pre-VM-Enter state when VMLAUNCH/VMRESUME VM=
-Fails
> > > due to a consistency check that is caught by hardware but missed by K=
VM.
> >
> > That sentence does not accurately describe what the code does.
>
> "attempts to unwind MSRs back to the pre-VM-Enter state"

KVM makes no attempt to restore MSR values to the pre-VM-Enter state.
MSRs are forwarded to a post-VM-exit state, as if VM-entry had not
failed.
