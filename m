Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589193;
	b=EsQMRFwB0zZXUOouCg4jc8/JjnybtoPGtopWYW04yhFrXzqWK0uruGco6u+1ZnNr+uSC
	 rfgIBKuSG9mSJTID1wqR6DEoBFRdagMXjsP5HxbRmFWwFgMudGWk51fS9m8j06jEoQyRT
	 QlGhW2zBxD6z96G5m7Gt0WcXoBsSHqhhmLU6X4+4YXIRw4J+w/DwBIZbXg50n0Wqxoq+6
	 df1+17oyhuGBADRo5nNUDP7ukjj86bSonjoVxzQ0sjw87zP2bfRxFa7UAo+cHNiSxDUdg
	 V9Y6AelZbFs5TpWR5lxliqiKcksSlVPJumBcBoWAnZMgROwZUjH3B2QhEyR6wR6M7QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589193;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wgzlMCkgAsu5CQiRrpZO0ziSJijVRb8hvM5ncdn/9m0=;
	b=Il7JrOxgqUfezLM4mFL79IcCZ+NoinEqH5HF7ODgSdQ4nQamDlpw87POhq/92kATLaIz
	 imyek9KPvhRZ75PQdXw15jVIMbnUFTgka+cgURySWBv039nENWlhm7AFMVtQg8XKrJFgD
	 eVBaY0bHg40M2RI+GPUBOFSl/3VDuIseN3DONCOki/LFDDYDaBLXVkQCEb47xBgisIltP
	 Dj7oJELRdsMTEvLrs7azX47/O+lZrg6xahIGTF8iWOsxo5044ujkuGFeds+o0gD3zWFDv
	 vu0zbBFKQ0sfzg0kGEm17OW5Fehfotu1I2UCM/Z+ONa7MdeklIzbQ60CGZr0amXNI/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeSwIvET;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9ED606A8A1
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AeSwIvET
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559801F000C5
	for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589193;
	bh=wgzlMCkgAsu5CQiRrpZO0ziSJijVRb8hvM5ncdn/9m0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AeSwIvET7pF2MKlQGYcTWD9U2qIRR8OCZ6gvvxiyOQpiYSJYmOr8bXT6ATdH0d7/X
	 QqbYFRd4ek78XnpKgpRsculhlu4tEahpl11g4xfnq2Bwr2SJPrNaQvNp+PwT4jDDpG
	 aJQbNiMR4Q5LupQ4cBSRcmflL9pHg1jgmpJ01WPTnVpU2lDHPS6agC213Rb9kS9D1r
	 UwBnbdMByZ9UJhh9msW2UBtu+goRHnv4Qh0SVGIBoPNmle/GWbT8x97HOxkqIciQUm
	 FSo2Ec2STCIfqjS3S1gG+FDTHaNOErZ6T5bUFlBRzR3Dlil0/yhFKRWwGAIELaE7sw
	 IwBGcpwZatExg==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso303510666b.2
        for <kvm@vger.kernel.org>; Fri, 13 Nov 2026 08:59:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEPzfGFxqsK+9v48P8IlcDTvBC6sAiPFnaoyHAtU21d1J08fCugU0t5toYNlY/CC1TsZDo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/X8OC0OEPRf8WdD2srE7VERQqJt6HG8W1fEA8CYUckLYI3QdNu
	17Fhnj0vSgco3cdkRfbFUjw4cFd3UtSxORFuQulhbPjrMUjhbmp+8TMF4AREjpxxTN+YBI5iCHt
	UOn6+ZCogHaMlm03d7m+eRwnyrZfDqgY=
X-Received: by 2002:a17:907:2d24:b0:c35:babe:ab44 with SMTP id
 a640c23a62f3a-c5095db3278mr321539766b.0.1794589192252; Fri, 13 Nov 2026
 08:59:52 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113162556.461390-1-seanjc@google.com>
In-Reply-To: <20261113162556.461390-1-seanjc@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Fri, 13 Nov 2026 08:59:38 -0800
X-Gmail-Original-Message-ID: <CAO9r8zNi+SjoNTQA49qZ=M+ScxKZmxGuCrXznXtVBnuJc1=avw@mail.gmail.com>
X-Gm-Features: AclHuK-gTCuxozU17TODtCi35T4jEwKOePW3MLI_7q9_i_p27j44pUugSqrBsbw
Message-ID: <CAO9r8zNi+SjoNTQA49qZ=M+ScxKZmxGuCrXznXtVBnuJc1=avw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Sync CR8 to the local APIC after marking the
 VMCB clean
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, 
	Stefano Garzarella <sgarzare@redhat.com>, Chris Oo <cho@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 8:28=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> From: Chris Oo <cho@microsoft.com>
>
> Sync CR8 from the VMCB to the TPR *after* marking all VMCB fields as clea=
n,
> as syncing CR8 can toggle the CR8 write intercept and thus mark INTERCEPT=
S
> as dirty.  Clobbering the dirty bit can result in KVM failing to detect C=
R8
> writes if the underlying "hardware" uses the clean bits to optimize VMRUN=
,
> e.g. when KVM is running on Hyper-V.
>
> Failure to intercept CR8 usually manifests as hangs when running Windows =
as
> L2, as KVM's view of vTPR stays high and so KVM never injects pending IRQ=
s.
>
> Fixes: bb365a506b1e ("KVM: x86: Unconditionally recompute CR8 intercept o=
n PPR update")
> Cc: stable@vger.kernel.org
> Cc: Carlos L=C3=B3pez <clopez@suse.de>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Not-signed-off-by: Chris Oo <cho@microsoft.com>
> [sean: rewrite changelog, massage comment]
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
