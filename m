Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793734847;
	b=u+cYzhXf3dutRNoxJl9GBOI6bV1FcZkK11PPt7VsZmt/A+qn/kPjMtFd3JcU0F6xRC5g
	 SKNnkUCDaSWy44v8T6fSKaMp9XGBoOusOabnzEaGeF6aHBbuTFrLIGBBG5CaRxKeDlXAh
	 qELq4cAv+EDDKd8y26QyOu3buvWjr8IzFxy81FYbmFtXmlFGFGZjty8LuX72coHxc4pCd
	 uxoFbTcgbatcdOwXuetMyAxnqeZyh0BW4+0r1fIdUf4jhoOqVMdbS+2PSCy/wf49HIaXi
	 0+A+ituGfe0isWEUOxbpFctaG+a18oQSDTVjH5dPlrgUT27LwUivjuwIEKnQ/syNSZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734847;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=QEdyje6GYOeiJ8aiWszqlJ8NcWeswSE5soiCL4nt5hE=;
	b=BFTgO+TXM9TxN35F+YRSHsOMAJ10f6SjuZAnBff/k3pm68outFDB3KUXP9bgqwCJ0/y5
	 dbql/39XVh1gQKBis67Ym1ekc8KFxAqrxKxClmhmHWwdNNaqenCWdHtsZut5+Tu47K6B4
	 HN5hyYMw5LSZuQYgevHmmbZLIcGuP1qzppGLcDdQ1cT4VgfLFomdEq86ZCHCFlehqqxez
	 u8I6C3o5QGUiBcRvWSYtN0TFTtN4TFCRyHL0s/BcXT/xfW31ORShm+WLm01/rz/PpokNt
	 aD3tgx22p9mpc27nN584s3KLpOKkxUmyupI3k0guRGWS9bBtESKeyF3o/nZUpNymybg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pT8oYGJF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56749606A328
	for <kvm@vger.kernel.org>; Tue,  3 Nov 2026 19:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56749606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pT8oYGJF
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so2066a12.0
        for <kvm@vger.kernel.org>; Tue, 03 Nov 2026 11:40:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793734841; cv=none;
        d=google.com; s=arc-20260327;
        b=o98ah1R7WqOwMXl4UEerTOIVEbXxg0ZlEjH+h2Z3KA6MYjISoXMUDklEE9xJ5CBIYk
         QkTZNJJ8jK3Q7vS0x6n7K7qKEoKaurYasipC7GeX0d2j9tS8nN635s8QFqKdp47KZQ94
         p8O/rvDQumkxoyDABLyH68JkwiiNeCIPJtSTSZeEN/QU8r2Lt2xQ6OK1SgMa/eR0iUfC
         usQDTp+RQ8k5BSxAWvhM5IVw+nIhQuXuDa0b3IKLtkun163HqV34hz8ytAILjIpKKDt6
         BWrFPzzwkrbyEMhAi5j+72cOinz5ON1w1vZRn0IqpyZMCATnpmtV7ivVJIECY5uKsEYF
         WoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QEdyje6GYOeiJ8aiWszqlJ8NcWeswSE5soiCL4nt5hE=;
        fh=G4l3PREVFAoyAU/vFliloAvVuDRxTX8TbQ5JB2jgzmQ=;
        b=UTd35VYgZkQIePiH6+AF1j/zc4F+5lfiXcnCEX6Z0P+3hQ4Gu0xqZZH+Q/4QWtqhVb
         /twcz4+noXT/RPcqv6VLjYy1ZsT3TyBdZb+nn79/tpbxHTyh5INc5+oXM9Ro9ihzNqwq
         WeG3BrJ8jOujTifqRKBUK2GD28foXdqy415jmHy7pFvz+QxbICmV7EPx6/qPABB+U7nx
         7gh+u3MAdLz6kjyTpWZ4TC0ob8Srpyuk4pLP3/5NNkRg/qdxqTl3zIER+59jSKJXm5qy
         rkny4aulPsz0O1NiEz+Z4B+fcXAtSTmXD2YwMBpE/JvTR+L8r/IXwpkBCZY9nszNqe3o
         onTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793734841; x=1794339641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QEdyje6GYOeiJ8aiWszqlJ8NcWeswSE5soiCL4nt5hE=;
        b=pT8oYGJFh4OylXN6LyeQXGxqmvowxZqdmP7Y3GI/F86yIdKK61uaZXbx/qqo4fe3LE
         K+10ICcH6HQsz0hOTk4irDRXR09D76sjU72Eo7frk2aJyBkj2dTV3oxzS65+g7fbWTC8
         wqA+FfIIFa350fcZQMunKgAVUt3C05tdFY7Jdp4RiUaQlqlzlIm8cY1WHZBTeMsmEZqE
         S2+gCEq5vSCj9X0osfjThi+pXaT1qJgU+NoTEx3rcxFkyG/2JGCTjrDSb8aM8e2Lh3Ah
         nu1LXgiXKkBl9s62wwdN3yiPrVRzPQZj9DxfH1T+f6cxa236+QxvMVFbUha7FIycQPcC
         tgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793734841; x=1794339641;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QEdyje6GYOeiJ8aiWszqlJ8NcWeswSE5soiCL4nt5hE=;
        b=mIfWUpWMXPZJikxbc7gXsxwdpQHyI9KPFgADO8YGR2SA2P3sgwG6e6Tb006AxGk289
         ixyNmCmwj2CoQp1Fv4VjZnbUD+QMEpYKYvhjAF8Tb659Cc9hJ9k1bjA6r8BCT2EG+5x8
         uk/iK5esLTZzbeMvMlNefXYZwB+SSr6SQ5GNl3AzncoAs8PA1PlPuO4QeTEFYXAVIhIe
         QeRH17ziU9XYdmDGPXsn0GeN+Cz3cbiEZfuM8iHhNZNZzw6OwnLQwxVzBSe23mhu073w
         pJ79y7aSkNErPN8HTOVydcTzhbLUpFjlGGZ7Ep2v+Mi1SAyKY8F28dymnHEXGZMFPoJd
         c2pw==
X-Forwarded-Encrypted: i=1; AKwUvBzyIqyH3gq3YsqWGg6a8HX6M6xl2JmD4uguM6khzok0NimnqZA0znsZ8iADBSbX3ht3N5k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dF0aJae74ByCwmpgSQaITY3oLlRnGq8krGQo/rEJH6j5FFdFy
	tr2d4FjMYSEyI0AxBJyOvPYJf44j+Hs73ShvaH6Tlmzrm81Wru5i751w3TxMh3n1++UzLDR0wTh
	oHzBX/VxxI0xz4NnT6Qr4/+DJufR/jotXT1tbo0wO
X-Gm-Gg: AYBFou0OnfQmdulg+/K/kHlD95AJyRhWVoFUHj147eE0PCHsXXii0axtYS6IiVSi6Db
	FTz0zgn21uyzpqv43AbftYFApMu2XbF/ARYrhjvp4RMd587V8z9efjC99ybOOFjLUi3ocXsac1q
	kCiVgtC85RMAZJeWirBJRd69bjJf2WEoXkPyXSzA8ISU5LNLO7+ErbNal0N6/GFYFXhbV2O2n2c
	EvVTKWqaJot/hpO4v8P+ki5Opx9zyydAVW72BZBnXXr/FQdAngrszHU0TontWCCdCM+vuxgWRg4
	xFimyzjW58js9y6e2HAsj3lYKNmAeIAfXuA2hFW6GO8Sym8VrRm1Kbw/CH52m7VWz1KdYu0aNxs
	K3WEFhWy5umCepXlUT71MK3W1s7e9Xe55tIHsYLCN58CV6148I3tqL0UWoQ==
X-Received: by 2002:a05:6402:b15:b0:6af:b196:68bf with SMTP id
 4fb4d7f45d1cf-6b5560924abmr11211a12.7.1793734840182; Tue, 03 Nov 2026
 11:40:40 -0800 (PST)
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
Date: Tue, 3 Nov 2026 11:40:28 -0800
X-Gm-Features: AclHuK-z2TRsVV5-P73NQ-eqccqZjCkcB6JcQTKj-t6dr0cpB0gWLBc8vRzU84k
Message-ID: <CALMp9eTdY3=1BrOYgov852VeAy3+Os7bvhWogvB0YF-JQrmtig@mail.gmail.com>
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
> > KVM needs to do better.
>
> Meh, KVM is doing pretty darn good, all things considered.  Yeah, this co=
de sucks.
> But I'm not convinced the alternatives suck less.  We've gotten the set o=
f missed
> consistency checks down to effectively zero, module the TPR mess that I d=
o test
> by running warn_on_missed_cc=3Dtrue.

I don't understand the TPR mess. The SDM says, "With the exception of
fields corresponding to virtualized APIC registers (defined in Section
32.1.1), software may modify the virtual-APIC page referenced by the
current VMCS of a logical processor in VMX non-root operation. (This
is an exception to the general requirement given in Section 27.11.4.)"
I would argue that this prohibits changes to VTPR between KVM's
software VM-entry checks and hardware VM-entry to VMCS02. If the
hardware VM-entry fails because VTPR has changed, section 27.11.4
gives KVM the freedom to implement whatever "unpredictable behavior"
we like. Yes, that probably does include loading MSR values from the
VM-exit MSR-load list, but why complicate things?

Something like returning to userspace with
KVM_INTERNAL_ERROR_EMULATION following a prohibited write to an active
VTPR seems far easier--and cleaner. What am I missing?
