Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447479;
	b=cE1qGFbrQvdXGlENPypWQHz5vJQAwaJLJ9m3nF2nXIkUIJFMycjeGZPSvovUomwhwZYB
	 9bRzBjFWP2FcVOXOeW0MQxDEpkUUD7pDO42eHDRuY2U2jKeLQl6xuOzMunWdli7xWjYzn
	 vow5QcV0I9q3LEczrgdaR4IEMKFUP6qjHwsi9SY2gjnG6e/4KD9PkBgjTlClcCY6s0JiL
	 UNybIQJoaG2WQtOxQP50f1tePnJDveNX4EaHrCY36unUhbmru0qGGQ/LEJrtIWIR7oTBh
	 sda+ST6SDXLcRtBmgacXZKXdz4h1s4XKckkrjPGP1mvdOiuzJ+J0c7MirKcaAbHGFTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447479;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=Hh8fRu5vFtpaCjWKRWOVh0V8299B/cNlEtDS6Intpqo=;
	b=1KcH0gF4oo2ThYKBPiurota6QKVyvhfjEYO8AUYS1NxmXo3c50wiZfqnB2y5y61VyBB9
	 F5FHBWpIEOrUsrSeRXaLBKiJxSJIHsTonJBBuGOwLbLYnL2tlqQe1OooBq2IJiZ5MJDFi
	 c6swObHWegOtfaNjPUILcnvSwBznojDby+1iEPsGfOx02vfVKlFaS/zzHGfe/sggZ02ni
	 GKFFIEcbBen4acjB2b2YOkaXlo6T2smWE5IBxl8kqui7f7c54zW2eva0TVlQVZGlY67yr
	 AHvLLS2qHrHRDjVbUVKDXYQKkfKAijfkOKGqb5xCW/YokTDElilaJuCFuImnjMGDe/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PsrWwWoW;
	arc=none smtp.remote-ip=95.215.58.37
Received: from mta1.migadu.com (out-37.mta1.migadu.com [95.215.58.37])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96928606A31A
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 15:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96928606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=PsrWwWoW
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gnvbL4VdHXSgoWEMo9YirAKMsnzbccETpFKUkQOB1eY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795447476; v=1; x=1796052276;
 b=PsrWwWoWxL8eZqKNZxEVbVwS9ZCWD+nf0jAvE9+ynFzOmHn5WFRia6hPitmqhJOH+x7+bI66
 2IaGkHl8Prmcs3Hza52TF6pTBiMCmBdiAp7BrIGERPHZyyXdVv2V0KisO9bIa0Y7Zkjie30JO+2
 Qa3TAXDoAKtDTpkPSP99DqpU=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6c68708d188c6bd2;
	Mon, 23 Nov 2026 15:24:35 +0000
X-Mizu-Trace-ID: 6c68708d188c6bd2
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c144eb2f43so9680e87.1
        for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 07:24:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErH9d4B+ZxTFbeFMDgkp81y+Uc6IasWN5dTS9V7SDf9RC0Sz2DOhYzhL1BQSrPWMR6VEbME=@vger.kernel.org
X-Gm-Message-State: APuU4Z8QU7KJLDenOZsOeriFCw89QnVDI1xJpH5CvIeLduL4VCUzBs+9
	u4zhy7QI4RqIJkGLZg1HIxYoczdWopFHEqDcAUkaoOvhQNyp5QE4shZG59ZTeCG15H/oUi2RppC
	Z9o/lmmLeKM/0uOqjlVI6sEq3fpR9pzOTm/MRfFpg
X-Received: by 2002:a05:6512:1591:b0:5c1:4cc8:2f22 with SMTP id
 2adb3069b0e04-5c21a249d31mr226456e87.8.1795447474671; Mon, 23 Nov 2026
 07:24:34 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123113435.1170711-1-fuad.tabba@linux.dev>
 <20261123113435.1170711-3-fuad.tabba@linux.dev> <awRKhCne0gG1gKZN@gremlin>
In-Reply-To: <awRKhCne0gG1gKZN@gremlin>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Mon, 23 Nov 2026 15:23:58 +0000
X-Gmail-Original-Message-ID: <CA+EHjTyM4_P5v0cHEiarq5XAb2A0Esshb762BLuuKnyBvH=y+w@mail.gmail.com>
X-Gm-Features: Aa3M54ohqjfMpFnSPURFY6Wicp7yckb5JMX6NA8ywvncNdbk8_vZnEW0TzRhLu0
Message-ID: <CA+EHjTyM4_P5v0cHEiarq5XAb2A0Esshb762BLuuKnyBvH=y+w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] KVM: Warn userspace against ioctls while an exit
 is pending
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, kvm-riscv@lists.infradead.org, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Nov 2026 at 15:09, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
[...]
> Very much agree with Sean's take here that we should instil sufficient fear in
> users at doing silly things (also in general not only KVM :).
>
> I wonder if we could add some specific examples or broad description of why it's
> unwise for better effect, though? Comments below.
>
> In general though:
>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Thanks!

> > ---
> >  Documentation/virt/kvm/api.rst | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index 89eb6be9bc6e3..980ef0cdc1c91 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -6974,10 +6974,13 @@ to the byte array.
> >
> >        The pending state of the operation is not preserved in state which is
> >        visible to userspace, thus userspace should ensure that the operation is
> > -      completed before performing a live migration.  Userspace can re-enter the
> > -      guest with an unmasked signal pending or with the immediate_exit field set
> > -      to complete pending operations without allowing any further instructions
> > -      to be executed.
> > +      completed before performing a live migration.  In general, userspace should
> > +      exercise extreme caution when invoking ioctls other than KVM_RUN prior to
> > +      completing the original operation.
>
> Perhaps worth saying why? E.g. (as I understand it) that for these exits the
> operation is only completed on the next KVM_RUN, and that KVM relies on state
> left over from the exit (including parts of struct kvm_run such as exit_reason)
> to do so, so any ioctl invoked in between might clobber that state?
>
> I see you intentionally avoided documenting the pre-fault case on its own, but
> with the above stated I think a concrete example might be example here, like
> e.g.:
>
> "For example, if you were to ... that would result in ... which would absolutely
> ruin your day because ..."
>
> Kinda thing :)

:)

I'm not sure it would help, tbh. I think a reason or an example would
have the effect Sean wanted to avoid [1], where a reader takes an
ioctl that doesn't match it to be safe.

Cheers,
/fuad

[1] https://lore.kernel.org/all/av5CBjbeidUUWiLq@seanjc-mac.roam.internal/
