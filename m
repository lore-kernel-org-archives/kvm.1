Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B656852F
	for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192990; cv=pass; b=i6ave51I6FKgQYnwUNAzEBlcasJ+NLpRGYSn+4nhL0SJHqffi7WUiHrKqKJvfW/JOdeWDf1MiK5wWYHXMhVHHRXZUHWsiHxMqsRHpk6JU5s4oB7Elu+xU2FKj0I1Pa+DA8HsWBe6ePA+gK+XjxBM4mCRHa8pyjvdjOq8Yh6l6To=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192990; c=relaxed/simple;
	bh=RksxLKnB3yS+nYXEiKhMFhIcCH6JcEIqRI8Y/4IK6Kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3AoXhgvOgO/l57di00FCIb1n/ArvjEBey3hK9RNk69/sKGwgGgSfo30GWKoNh+3mvWVsqNMPVuF8cldyG9CoDvy/Gia5Rdm/ShnJMORKK0F7PITA0xn6B77hl+CmL32aBQA049G+83yyPUqi+7YEdKlSNZD0WCTa3lcQlergig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LaEh9T+V; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LaEh9T+V"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a5f95a879cso2684a12.0
        for <kvm@vger.kernel.org>; Wed, 23 Sep 2026 12:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790192986; cv=none;
        d=google.com; s=arc-20260327;
        b=PzkL5jmF+o2dixd+4mmmtSo9fXChBH+ap4xEeBWocngRNQDPGakg26aD/KfSt62z+E
         O87BSPjO2+bWgRn5Fk9bONWBg/Qr0JROYGLe/kSPqNppEXWyflXBx2hQeg+iYKCx03/A
         aUCm1k5vidjBKXh72uAsZB+UxpnijVA3VrDzkxqxXB7qcGmApDgDd7TC0o9qh/a1JoBB
         aziIKdZj7ZPOK26cywywYPsVbmPslOotyzxo/b4ESGHWgxRnpMkI0F+FkjJPNVnWkZ8Y
         SBer4BgLH56y0WiZnxmGXWGRBsT/mEvvXQlALj4T+TA8aHfB+SslCVN+PLTYD+Sd81je
         bgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zg+TRF2hlMBWlKMGW490ituj1VT149iHCF+fbR91AZY=;
        fh=t4ylIoRZq4JtwucN9ZBW4o/CfeCEkZnL8rS9UL7eZmw=;
        b=hRLIpk6hzDxeRIv7tfebvs9rkJDx13Sx12RxsMxQ3zdzX10/JOxMwlDP7K5Ci/LhGm
         1RZP0o0rOGadHvqbebZUXO51ginqXo5PFiFgxSYjysIv8vPTRHSh/qzMdKxrWjpBLivb
         WGMC25ULPUIptXn9Q1wlST2TUO96mqN9xH/cAi02AkbTfuSC4/JSaonLs2WAHRM6jVvH
         Td+Dul47H5x4os/m3icmNNkBuClLH3TqSKvv0UgzaJOVLQ6kQwZoqqggLyLZGPWQegQL
         t13b+xKF1KVeQmcLrXwDekvYfYHelodbTMlDw1b4V8K673BaoOn5d9Rbf0/ctHrZlVkw
         6srQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790192986; x=1790797786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zg+TRF2hlMBWlKMGW490ituj1VT149iHCF+fbR91AZY=;
        b=LaEh9T+VhpbtNX3w/zEMWVHTzQaNgN2gquOOZCGIATw0zL58ufmqhUvrJALMVBT2dI
         5M9C6MHdaknAoJUBO8gJa59Hd7+Gbp321zW9hwkUUZI4DxbdjLsnmdFG94knMYDYzlgi
         UaoEF1dgi1mXvTpU+nfoE/dIsBxjSbA76K8nOxHTXmwauJ7yOB9b2OuONgns9v6NJOL8
         DTWLoO/EIIDhWLzQp7RRj5uP0tl4iLYfR+SBKXYD13HC1iYWVSsQKeN/1cGKADA1W2y/
         LwIWmo7Nf/FqVmEC/MHG43lZIvmiRlyF88vV7h//Pkhx4J8IyBvGFFc729mJjUCNYQ0X
         BqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790192986; x=1790797786;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zg+TRF2hlMBWlKMGW490ituj1VT149iHCF+fbR91AZY=;
        b=J7gTpfLfbW8sg3UHjKUxPSXBmvaUH3/nZyD0ouPdKQzNWm5E6Zann+e3z9T0YJbEEt
         9K31KKGbqd+SGgAmq+TfZs4P4LPtNsgtKspNahIL4jGeQut9PY1AgsJUx2PhacZyhtPo
         AXshHLLU87GQlKoq1C8DhHRz4NKYCgOp/h+X4VC1GueQXZr0y6HMxKmGBX20ACSu3Gfc
         EhFJPeP1njUleYcXFgnGpu0W4DjQy0Vj/b4rEIsVIfBidFP2iQHvyO166pVdd7pC1LTn
         5ymqLbOAA3ADgemfANIaZG8eig5sJA9b/bF4F6rMfil4+RDjvzfrgEa+MXfOqSUTiYv1
         A7bA==
X-Forwarded-Encrypted: i=1; AKwUvByiZQj4niHMZeJRBjK7Y8uyudM3gOaSeC9Ua2ZjhASUTMZD8WfMdB4CqbOjgNoGqxa85YE=@vger.kernel.org
X-Gm-Message-State: AFuF++ly/MXAnI2hFJwaGw+OrgvQIo3tbXgrhgx4PqwshxG7qZQohRw/
	wtzC7q7yeJ2WqLdn08R121XdcCqY1TXq7O8vDnvuWkadJIeF265bV/P2+MAtFSQ3SiM5Il6bgJB
	zd5LCsFDbEJO4bu+c0I2CGS6eKY6VD0HYWaXwczSg
X-Gm-Gg: AYBFou185xaS/P8INOiTC/4SzXuy3kcwsSttLddIWLR6LY8KTFU697aDoayOz0yqENe
	gNEXLYciQk8RlLHiIF5epX9TaOaX4VwlOMn9dlADjszPdzBiKQAGWnvvPK/KxlLYWIb7NqeZYLV
	faNVKiPwEu4kA+GlWgKGE+QKI69xtsYvZEgeYPgaG+lSE8UADzueh+Fpc5RJyS/jimgFLtAbk0+
	OS7XWCPbphyZlIVJlvxdV7ph+7om9pDwMwz4et0Orm/sL8Krrb6tW95xq29+zmzLCW4J1Khn3id
	aAKzbEclGgL3mPGTj0DGaRO4Jrz28UhNZInOtvqxCXlUfoKApO3F97s=
X-Received: by 2002:a05:6402:1c0f:b0:69a:f1cf:4849 with SMTP id
 4fb4d7f45d1cf-6aac7c0a102mr17386a12.2.1790192985525; Wed, 23 Sep 2026
 12:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790171702.git.zhang_wei@open-hieco.net> <ece0aca2e99edc2cc626e0a8e61ccace80a28d74.1790171702.git.zhang_wei@open-hieco.net>
In-Reply-To: <ece0aca2e99edc2cc626e0a8e61ccace80a28d74.1790171702.git.zhang_wei@open-hieco.net>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 23 Sep 2026 12:49:33 -0700
X-Gm-Features: AclHuK9wDS3j_kFU_z29aQCAAxsQCqLzUICOjyr0No49JpSQevHnMBu9QJNROds
Message-ID: <CALMp9eTyC5fhWnhbf1_npF30NuQzoAmuTbJe5mkG5Kv3_P3a=g@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] KVM: x86: Provide INVLPG linear address to
 intercept handlers
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, zhouyanjing@hygon.cn, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 7:02=E2=80=AFAM Tina Zhang <zhang_wei@open-hieco.ne=
t> wrote:
>
> INVLPG's memory operand is decoded with NoAccess, and thus src_val does
> not contain the operand address.  Intercept handlers therefore cannot
> construct exit state that reports the linear address from the existing
> x86_instruction_info fields.
>
> Add get_invlpg_linear_addr() to compute the address through __linearize()=
,
> using the same flags as em_invlpg(), and pass the result through
> x86_instruction_info.
>
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
Reviewed-by: Jim Mattson <jmattson@google.com>
