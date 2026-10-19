Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792447804;
	b=dhFrTdR+tWevI+IrevlWpfWhKz9+AgoT9NBV3A59WCPkt1grn5M6rYoNGCUwcCOK0dyK
	 vBIPNRIOG8a0rN79rqmX5SE6OQXHUagCDDasIfuC9ioU3cvc6kZuViI4bbDO3bjKjsBIh
	 27GjHBhJp0DuS8I+mQmXSGN9SYWAqMyerBvLXmnDN7XCIkRk8JKbh6DKTkzEPQNpD6nhW
	 tL5ovtnK/CAayDoT5gx6gMG6vRnbRUdwqhhJ8VxROloKNxQQL39M+FxJFdrrEAi6ORe/p
	 ceox9WQniqS4KQtmwDoH9r5KXSRnB9Md1nZgRBayReUuB6K8WpXvWWX3Dz4VIFATmsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447804;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1cZnOnOEypoCFC1nlRoSNC/CY7xywFH5Rd6n8NA3Rsg=;
	b=Ntv3gxpdEznDmwaaVqqMLJJl2aqaDlBEKbLFvyIpMWByensfx/lyl0femBBhr3SpG2cw
	 UJ0+13JMkKVf9rQNBwCc6upZR/1/bAD0IqH8VQ6xTTTo2lCPv4AqPuXK9XDJbn7w1LmUZ
	 twDzfY8z55zE1l6KmV3aVrKWMhuDbXkrzfHOouqdbHlDAxnc/VdQWhPJdjhAhTY0TD6HI
	 e4P78qu3iV6UWnBGhf6YWQxiY3xFEwqTg9Hyd3zLTixqK7U3Od4VFVPEFJmxO4v5uCSm6
	 JdldsyjvPU7MwRzjblMqzuTArTzs/w5BQ3APsyHmSamA2N/c+maryec5Mke34BC8N9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Q7ITBmLn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDCD606A31B
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 22:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFDCD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Q7ITBmLn
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so4288a12.0
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 15:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792447802; cv=none;
        d=google.com; s=arc-20260327;
        b=ReLwyNHvCCdgjtak/JfBPba+CTNAsVv22HUaW0reFruKpdbb0XpFxOxk9i+F93vZ9X
         U/7NqnMCxrGLQ/9p3oMi2v5g4f8lp5fAxeCcIWU5R5lCjzlPB1FgXx2i4rFcUPBjSkho
         FPScuGAY8Mki+pqcZ5b8nYokEiR+XT4rzABiSUsHua5bT7Cz5TFA76HBUPYaBWEHjkp3
         cfM/XzHulCrvaLZC3CUkRqRhlOxIIu9CG7XrYdese3Xo3J0RrPSbJ9iBqUQumq7GhD8L
         1FvTS55SX0+6ap0Z0jzfEirn7JadjhsZfYkFQ5f7TpRXYyz6aZrYH8mlr+BwnMKuJTS/
         BBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1cZnOnOEypoCFC1nlRoSNC/CY7xywFH5Rd6n8NA3Rsg=;
        fh=FF2CaYB9Hd9dAkKQvcXRub1ULhUM4IBdW2G0x3zoH+s=;
        b=K8jT6FQ0y36TUSta+I+Y/vc93CN9+ZdU1Z6Y/NDUed1qkLVccQ4iYHciZ5X/ebFrWD
         15bz2u/5Yb4j8Bn2i7RbBqa2Mjh7GpVD8MvOj8l56O8y+Nol6H2y6u7+Jt3N5mP+l8Ga
         YbgrfBLCZ36TA+3e4V6aeo4M22+sj2Q+kCIs5HfJKdLtkx9hSZEgZ9Gx0QccmGxCpj6j
         eSJhLfNS43LoKtD+mFefWGPygCCZ5Y3gDf4U2ufHAFtIJoX5udh+vWskucPXoF0et5Lg
         cgJvEHpTsdcGvtWb0qh1GEnl4brJRjTlmBCrTUDtpyPqVxWz9f9FvFrKn6WLkchRENXF
         acZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792447802; x=1793052602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1cZnOnOEypoCFC1nlRoSNC/CY7xywFH5Rd6n8NA3Rsg=;
        b=Q7ITBmLn6vhCCTz7XPZvnExYrlV+byWlU+yAJCLjyj3pKGF2nP3N3cOkVwgAXkZLIm
         QEFok32ib6ygpWoQXbiA7hh/Cp8ed2BHZlI8mR5EPbhalQJw1tMDWtppPkz9Ez+wFq/l
         gE7TrrlFxxwFEw6FgHBpbimlSaEB2GqPYYm58Q6yvPKfpPXAkqKwejFGIQ5YDlm2q9hC
         1U/VUX7bqfD3YI4KpGCsdmOuOI60qmvm5I0KbYsczWuwx/sZmvbOjB8UbN4YAUTErZR8
         2DA4if1YH+ExhcQYpdIPwdhf7qihCqPJboEVXeHlU57fddj5QgDEXBZf+63Dyz3kb3ii
         K/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792447802; x=1793052602;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cZnOnOEypoCFC1nlRoSNC/CY7xywFH5Rd6n8NA3Rsg=;
        b=RGOoAv82jO+veHAjunQnkeehf2mlm3oWZlmv8w5jrvYrndPQbxcLLi6Qw1TnXfpsaW
         RsOV/hh/zb5wcqv2qA8lT/8gkcQrbkz4PwVzc3orP/GlCqrGd/JbSZYoUMiIjkuICkiL
         edZ7a27pbnhU1VFBOnReL3q1jDTjocdyExcU9uepH7VUrmwrx2EMV8HAZTFMz30eBY+9
         PDThGUSTTgvvmIWJzJCGB1ABPm4OyP6Iua337Q8R4IryjaSpBiY3Gnwh4d6Eu/ryJlnm
         IvTD6VRU4e5vA0Q4IzUOmoApWPTwhJ3mws/wTdLalI36KDFiFMJFQFlmZS1Kd7/X2UE5
         U6vQ==
X-Forwarded-Encrypted: i=1; AKwUvBzn7bMoYjezU1QtgvwKnjJea8EmJ74CeUWfQR7rR4HCRPjnr7MpvPnGlZIx1vTs/Q3tY88=@vger.kernel.org
X-Gm-Message-State: AFq9FYKAVLsLiPMfzWnlyGg6FvPsipljw4PBaK0SJ1vYGK2JsCMH6v92
	vQuNcUG257v+JSu0WgyhZw/rvrWuuQcxZHE8CzVsQJMII7XsRTHN74dTkeSXbp/pdhe8BCTYi0g
	KZbR08hAo401M/w8EPAAYeOvaC05NFImLrjXmtyCeTirs3M73ZGBOQ+GB3Pk=
X-Gm-Gg: AYBFou2emkj/E4ld9eCF/+Zs+BJIeHyYj4rR8Bk5+/HLdEVZYbSrV64AkIs9gnT04TG
	hVJEsJxpRaNi5+BkzsuILz3rKJvHBdRWac1V20dDJZATulDo4sAaGB5X/+9QC0Muhv06dFow0rk
	e5/XhH1CTF5HQoROl9kq37tNPtCD3HMpWidcuwMMegmIRwFEwzcBnDwp1HhN6UKct7mN+H55HEq
	pSwgzF7luamLYQz+DBmhFsZlZwaTHhinXWD7JfgSNs3LfMwhn9HJP4hzSFFrOzli/vbBfdpkQKS
	AUyclYq2RATICrbke4jc5PtH7puBk3fmW4dYrDfXKvUD/THB4+HJjXQ=
X-Received: by 2002:a05:6402:797:b0:6ac:bdfe:116 with SMTP id
 4fb4d7f45d1cf-6b3e772e733mr6253a12.16.1792447801809; Mon, 19 Oct 2026
 15:10:01 -0700 (PDT)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019210532.378628-1-shivansh.dhiman@amd.com> <20261019210532.378628-2-shivansh.dhiman@amd.com>
In-Reply-To: <20261019210532.378628-2-shivansh.dhiman@amd.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 19 Oct 2026 15:09:49 -0700
X-Gm-Features: AclHuK8Lba8aNI3KUOXui4cW-8t_ENSwSOHlb9SZ5tm4ps6eNoOmvE96b_eW_6g
Message-ID: <CALMp9eTXz6vD9iUN0mXPjwbxK_ZnocL+BwS3qbphSUFXzmeiaw@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] KVM: SVM: Add VMCB fields for LBRv2 virtualization
To: Shivansh Dhiman <shivansh.dhiman@amd.com>
Cc: seanjc@google.com, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, peterz@infradead.org, acme@kernel.org, kvm@vger.kernel.org, 
	x86@kernel.org, yosry@kernel.org, thomas.lendacky@amd.com, 
	nikunj.dadhania@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 2:06=E2=80=AFPM Shivansh Dhiman <shivansh.dhiman@am=
d.com> wrote:
>
> From: Sandipan Das <sandipan.das@amd.com>
>
> Define the new VMCB fields that will be used to save and restore the
> state of the following Last Branch Record Extension Version 2 (LbrExtV2)
> related MSRs.
>   * Last Branch Stack Select (MSR 0xc000010e)
>   * Debug Extension Control (MSR 0xc000010f)
>   * LBRv2 Branch FROM (MSRs 0xc0010300..0xc001031e)
>   * LBRv2 Branch To (MSRs 0xc0010301..0xc001031f)
>
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Shivansh Dhiman <shivansh.dhiman@amd.com>
> ---
>  arch/x86/include/asm/svm.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 83fd49b26a4b..d76844224745 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -372,8 +372,15 @@ struct vmcb_save_area {
>         u64 br_to;
>         u64 last_excp_from;
>         u64 last_excp_to;
> -       u8 reserved_0x298[72];
> +       u64 dbg_extn_cfg;
> +       u8 reserved_0x2a0[64];
>         u64 spec_ctrl;          /* Guest version of SPEC_CTRL at 0x2E0 */
> +       u8 reserved_0x2e8[904];
> +       struct {
> +               u64 lbr_stack_from;
> +               u64 lbr_stack_to;
> +       } __packed lbr[16];

Nit: instead of '16', can we hoist the definition of
SVM_LBR_V2_STACK_SIZE from patch 3 and use that here?

Reviewed-by: Jim Mattson <jmattson@google.com>
