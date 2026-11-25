Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635842;
	b=IULdEUJxwBmYBav7DacyIG2Z5sms6YdFSsj9+61Rn24kFRsM4tzBQ5+qpvk3PqnNklGc
	 J622VlwGFcj1P5PMmzDiGjOjKl/FTnuNc7SB5y3RxYtm87pZksN6ySV5SXSTEaehMgpXV
	 rdA7a05b6TELEvXcFt6ZjQFQUAr9oqpVI8r2lWGFPrp+p8wMlDxvw3P+ehfl84A8wrUfi
	 7l7DWl593P0DaCN25gSl2lbE2WaM69MR1MG+G7taCZDbAzBrdR6Nthuq1ARPhEBzeAc3X
	 Nd5spxHxJzxSWv96rxH/SM2MhyHTHFlJdgygD9P5wIUoqjgHz9lIIPLS1jMYkDLxl9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635842;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vRPmU+/hfY//G5IeGfjJPt/W101rY542B/faEGkldBk=;
	b=dFoLiDR9yqOTDdLWNYK3K4pWDoZS/FJ6GE3l/hWz+7JUzFs/yMiKWXN0FmNUQiu1mO6G
	 2mt+VkhZFsE4fo8KNTpZr7+ADN23WOwVktoPcIPCvhFVVDoYLekReEnxMuuEpRy2lU6hp
	 oUH1/p5oIykRiA8KRANzpEFlvQGXzWllwd6X1mV1EYjp4do2B3eDrxCu2wPc3jbepWUCS
	 f8tU8yJyrqrSIKZMgdUJ5HTXkClfY5qO/qI7mgR54bRT0HsImExVdC9XVYCNVxzbSmlXv
	 oGvQt+bPUOLJa6ziovgw/Y/L1vF8NGwRQsLYviEfwEFSqh5WxuQEqhnoaSw+VGOs6LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XG0UVB9C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB9606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XG0UVB9C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530B91F000CA
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795635842;
	bh=vRPmU+/hfY//G5IeGfjJPt/W101rY542B/faEGkldBk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XG0UVB9C3q74ZOqMzsPtnfYbZeusKzlFSNTjyukGWuKYwFHmJM6Zr4nJedo9bvqNn
	 9f2/0uEVQVNq+2M7Vck5NZmyxcQS1Jj3NfOpr/cxTvZBue+ZvJGXF54VL9x9TdrB55
	 8v+AM0enAkb6XmZUKN0C4qrmxgaE55a+wONSBsnc1QGiZsgGcVhCM74Cag0rmyJxLn
	 Sr0TCvqG4mxy8c2O8os6smow05ERmmEs2BJGp97ccKXg4A6f7UiF7oMe6x8pWyZ2Yq
	 OODJlkur0+ojdxQEh4WKX+SA7DC8Wzvh2XptyK9PzICTiODt+0lFNX0WFNkegy9eV7
	 5n/2sKUeiv7Cg==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b8627e0eb2so8155127a12.2
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 11:44:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFi3JqzHq90p9S7EqnvCJMnOhP4yTrLEY9weBMsg1zpy46JdpmlJUOUv8qNmpXcAN3wX4Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/6/RqSdEF/qZS5jB9CUqnMFY2SoWMOJz959tWCFpIwkT0UfWQa
	bsrDEFlv4MUUzYyjbbWRhle/2YvEErrWDQBwdyiDXGNHTxH4H/ydAHVCYQvwsTEY+V9BmDK3hhO
	VqhqHHpCf3osI7ISHNRwu6icZMj3WfZs=
X-Received: by 2002:a17:907:da0c:b0:c50:5545:b66f with SMTP id
 a640c23a62f3a-c513a803353mr1445531166b.23.1795635841280; Wed, 25 Nov 2026
 11:44:01 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118233719.2101265-1-jmattson@google.com>
In-Reply-To: <20261118233719.2101265-1-jmattson@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 25 Nov 2026 11:43:50 -0800
X-Gmail-Original-Message-ID: <CAO9r8zNV3w7bQuPw59Y7Os4Z-1K3Ba6QWwp2TvJdY-fNhBiWUg@mail.gmail.com>
X-Gm-Features: Aa3M54pBdwALV85djUZxebzdMfDvcMR5Hg4ZKY8Tzpg3YhE9I1Axp16L5ZNrY6U
Message-ID: <CAO9r8zNV3w7bQuPw59Y7Os4Z-1K3Ba6QWwp2TvJdY-fNhBiWUg@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Set V_IGN_TPR when enabling a dummy V_IRQ for
 an IRQ window
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 3:37=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> Per the APM, the processor takes a virtual INTR interrupt only if
> V_INTR_PRIO is *strictly* greater than V_TPR, unless V_IGN_TPR is set to
> bypass the priority comparison.
>
> In svm_set_vintr(), KVM injects a dummy V_IRQ with V_INTR_PRIO=3D0xf to
> trigger #VMEXIT(VINTR) as soon as an interrupt window opens, but it does
> not set V_IGN_TPR.  If V_TPR is 0xf when the window opens--e.g. when
> CR8=3D0xf (in L1, or in L2 with V_INTR_MASKING=3D0) while a TPR-independe=
nt
> ExtINT or userspace IRQ-window request is pending, or in L2 with
> V_INTR_MASKING=3D1, INTERCEPT_INTR=3D0, and vmcb12.int_ctl.V_TPR=3D0xf--t=
he
> priority comparison (0xf > 0xf) fails, and hardware masks the dummy
> V_IRQ indefinitely (also stranding any VM-wide AVIC IRQ-window inhibit).
>
> Set V_IRQ_INJECTION_BITS_MASK (which includes V_IRQ_MASK,
> V_INTR_PRIO_MASK, and V_IGN_TPR_MASK) in svm_set_vintr().  Note that
> svm_clear_vintr() already clears and restores V_IRQ_INJECTION_BITS_MASK.
>
> Fixes: 649d68643ebf ("KVM: SVM: sync TPR value to V_TPR field in the VMCB=
")
> Signed-off-by: Jim Mattson <jmattson@google.com>

Reviewed-by: Yosry Ahmed <yosry@kernel.org>
