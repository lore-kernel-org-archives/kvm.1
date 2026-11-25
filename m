Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642523;
	b=cJUP4rYeOD1L8aOA0too+tMRPGioZa8r9jmc3G8Wiwc19QeCH5uU6bFV1IkFA4vVo7eg
	 dCtSgi4g2POQNR3HOB1I/x78PCp0nGuaOi/htA+gwOTBU/ZMtD5gXfD/xmZjaHtaEt1ud
	 9c9A5OmjftDBbsmgLOwbCQqzK/3VC/6r5lisVkhEtpjvO4w1qqg7sq/rbiHZljkkhMLW2
	 NDXsYThsbyaH8higH/JGpQSKAX67b4CreLNYzoKcHkTOA2oFHblaFPwpxPjM/ZIAuH9At
	 pEC/U8saZkvnJiWX4Ae6yNUghi/9xxrvtrrT9fXT7ebQU47gQ2i5hvhXTsKkgjPKu5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642523;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5DT2gV6MaM+tF8dMnUSxLFbt3tl2B/cDE7HAdk58XGk=;
	b=X5TApaGHSsZ7n5GCy/2wVha9PAZRuaxmhEqa5KEddKpkqiFbSPhnVYTa6zPsK6kIN29b
	 baBi4Z9jzBH6WaRB7XFkx8Q4GiitMxlxtxU0otibVBCDuyxtcXw2k4qlr2dNG+y0I1UoT
	 pkAsk4/XUlPWUl0ywqo7uFF7a+l1+lBj2K/dAOpa0+GuHHQVDeRuk8s6+0GWoCDVyr2O9
	 I7IA2et7S7i3bcf2+pR4liqPLV7ojqT6J56u7x4RP+W9asylTkRboHtjagBiS60y+zg4W
	 tMAJFYpOEt+mYkRIX5qeBEsXG/sj10uDcY0ZE83xvKg4cKCz182yjFS1EsxvmQPwqbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQ7UQmBA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2F8606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQ7UQmBA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029DC1F000E6
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 21:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642523;
	bh=5DT2gV6MaM+tF8dMnUSxLFbt3tl2B/cDE7HAdk58XGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cQ7UQmBACZimGfW+iREEhX79jlZWKHRN9TaV5A9hrIeItvnl3NpZRApLGq1cn13hN
	 BzevCHG2zBPY1eqJu2zzO5zsOke4gjuYTyKJmBzmiiN5yhO23NyhZdKUKd/3O4fKO1
	 5PRif6vVTR4ugwAjUniaJcm+fsTAGflnR4/fJn9qag3OFYJQ1BdEzGdWbgLeSKjf5r
	 APVLdujkIfrJ8OHAiya3R+q4sixrvhBUOR9Mf0tydOTa9329tQAvglSyHaY012wWJY
	 MFPz2L368H+sMz/zs8SjchYXvYunVHu/vwxtb5OIar5qruljOxWkdmXkSrOYHy4nNu
	 3YRz6Wbm/od2g==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c5188e4980fso167374666b.2
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 13:35:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGxI2fkoHataB9j/ioRH4c2ui11iE8u8LGXrF2zTdGCJQySPBRrHlJjjFdRpuuJvR4+lv0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+WvNfdmkhKJowIo3oJwmTwoXDaHQxzKYQbw7PAKUwT0BDCZMt5
	JeGNw76/M8C9hbyvkJa1mU36P/Esh/ADMzFk1PT2K5vJxaoZu8VUBcHJNA1WSZgJKldbXZRRcTg
	u+cQhG8xOkArUV3A/CQIMAwv89zwC6Ws=
X-Received: by 2002:a17:907:584:b0:c46:c3ad:e1ca with SMTP id
 a640c23a62f3a-c513a84dcf9mr1208760766b.9.1795642521937; Wed, 25 Nov 2026
 13:35:21 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117210934.7765-1-seanjc@google.com> <20261117210934.7765-3-seanjc@google.com>
In-Reply-To: <20261117210934.7765-3-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 25 Nov 2026 13:35:09 -0800
X-Gmail-Original-Message-ID: <CAO9r8zOBvYsOyZLoKKTVfomKKoH+4S3KPYVJ_70p_7CJQrdzSA@mail.gmail.com>
X-Gm-Features: Aa3M54onVOC7uzSKfhzckkF_0xlFJe0eUYkk7FL4UqOts70dNltmqRJ0FRmKC3A
Message-ID: <CAO9r8zOBvYsOyZLoKKTVfomKKoH+4S3KPYVJ_70p_7CJQrdzSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] KVM: nVMX/nSVM: check unconditionally whether CR3
 is valid
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>, Sashiko Bot <sashiko-bot@kernel.org>, 
	syzbot@syzkaller.appspotmail.com, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 1:09=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> nested_vmcb_check_save() checks CR3 legality only if long mode is active,
> but it really needs to be checked in all cases - the check uses must be
> zero bits of the host, and indeed nested_svm_load_cr3() later will
> reject illegal CR3 in every mode.  Move the check earlier, and thus out
> of nested_svm_load_cr3().
>
> Likewise for nested_vmx_load_cr3() and nested_vmx_check_guest_state().

The code looks good, but I think the changelog needs to clarify two things:

1. That nested_vmx_load_cr3() is also used for host_cr3, but that is
already checked on nested VM-Enter and cannot change in the meantime.
2. That nested_svm_load_cr3() also checks L2's CR3 in the restore
path, but that is already checked in svm_set_nested_state() (i.e. in
patch 1).

>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> [sean: tag for stable]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
