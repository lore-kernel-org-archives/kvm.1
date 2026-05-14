Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38A33ADB1
	for <kvm@vger.kernel.org>; Thu, 14 May 2026 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778784722; cv=none; b=HHQjn9NkeTzIENxlY0F9QOS1yOOVp6HroWNIQd4MsfCf8pRy8fxhSorIVYtMWh/dZpvUfPIojxNbJE+Bg54875b7D2xW52ekViS6to4FVUQFto43U24cBEOK/Yiq7kyCjPrL3cxlHTe2i11fTbkEfbdKZ3qwOb/qrK1jGyWFNHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778784722; c=relaxed/simple;
	bh=ipknFUVY08c/OyZgQ4DVl3qiLBlNgpQ78duTHUZvTDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=abUPrx9tZ3KXZGjrD7QRNGOg2YNVpdIVRV/7ADKCZxNLfCkIv+XFD0KzeBd3ixFPTVylDGqZ5RvQD0HK7gcvBhOW0QHC7SYJ8UdSlkq/YEZKzY5+jLAPuczq9AxieOOh0tZwKiOcLo2/OGZQR+1Ta1hwOVhGz3qUHFRBvACUSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ezo0sdPj; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ezo0sdPj"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-83cecc22d5fso4360300b3a.2
        for <kvm@vger.kernel.org>; Thu, 14 May 2026 11:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778784721; x=1779389521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrX8LRwW1PSowT2YAxKZhUffJgpdoyd8g+oYXgBSXz4=;
        b=ezo0sdPjEesNfcNDiRWi19y1QjRyAlFa6HsxnuJR6+kJe5sOJrW0GRDGe9J4tI8wF4
         6kLMH6j3WGld2TmcpHKjjL8yvtVZo8StGn5yh2Gtbqrfb/gYNDbKB4t2XSEKCWb8uR6t
         V46Is7xqShPpgsHD++wPb4hGahqJ1BjzjNmLnAZ3OKl64bTswuLWu7tRtR/fJNhQ5kaA
         kOU69StJYybPj0KyCQebbw4n1V+uSPgNSO2Zb2Yeal8txhIWb2Nb1eC5qpM+q3ncQzYl
         Qap1TpbFZzhr3CMGPdUgRc9JsoJpQB5RYpEsfEwwIIc1NKGIEKrZkFSeGJIU0qgESlim
         1+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778784721; x=1779389521;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JrX8LRwW1PSowT2YAxKZhUffJgpdoyd8g+oYXgBSXz4=;
        b=Arc/ZFsw+AMtI/q7PZw7GxMU0uFvSl8N54ecHGuLdaSvb2VwUBD++NcT+khv1+0NlW
         wk2QzuEtPaL6Tr2jVJ60YnTJxt6lWlcjhJ1V1xHXmOtofqJCtSnD7j2hAn6m7eDPqULQ
         0ZPlQIuv/no2p6sZUA0wBRM6WliF8Yq+Ah1HkYtNGXdivcT3W5+yCwBAJf3ylB9Yi8aB
         jqo+/j27oViS3FsFhxIw4UH+W/zMnueSAyn1Kpiwu/geKr7yu4L6H3DvqV67d0b/761K
         CZWGkSYwUCu+RKKdjUsHU5HcTY5x52IHoQfn84LMgBNs9L+a8xtgszzZrT5J0IUs+ImY
         AySA==
X-Gm-Message-State: AOJu0YxHlf8hpkOCsh6gVBBYO3U8Jwmgm6LVgmCWnw5gJWsML02imMRB
	JRo3OmPeS9uQYiIJ0snhXl/sYXgrvyUz/v+dW7ffZt4u+Z9XPSd6aLW0y7FvgvC4GQT9vlOcYiB
	Hi1niHg==
X-Received: from pfnc7.prod.google.com ([2002:aa7:81c7:0:b0:83e:d99d:7c4b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cd4:b0:82f:5d4f:7355
 with SMTP id d2e1a72fcca58-83f33cbcc50mr861095b3a.33.1778784720342; Thu, 14
 May 2026 11:52:00 -0700 (PDT)
Date: Thu, 14 May 2026 11:51:59 -0700
In-Reply-To: <20260514053105.GA109150@k08j02272.eu95sqa>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1766066076.git.houwenlong.hwl@antgroup.com>
 <e0df5d6812da0f508cdf697ac7627693199c8293.1766066076.git.houwenlong.hwl@antgroup.com>
 <agUFxrpUhBRv54ZV@google.com> <20260514053105.GA109150@k08j02272.eu95sqa>
Message-ID: <agYZz7D6OXsEIEYF@google.com>
Subject: Re: [PATCH v2 9/9] KVM: selftests: Verify 'BS' bit checking in
 pending debug exception state during VM-Entry
From: Sean Christopherson <seanjc@google.com>
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: kvm@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026, Hou Wenlong wrote:
> On Wed, May 13, 2026 at 04:14:14PM -0700, Sean Christopherson wrote:
> > On Thu, Dec 18, 2025, Hou Wenlong wrote:
> > > +static void guest_irq_handler(struct ex_regs *regs)
> > > +{
> > > +	unsigned long target_rip =3D CAST_TO_RIP(fep_bd_start);
> > > +
> > > +	__GUEST_ASSERT(regs->rip =3D=3D target_rip, "IRQ: unexpected rip 0x=
%lx (should be 0x%lx)",
> > > +		       regs->rip, target_rip);
> >=20
> > This is wrong, and the test fails with your series applied verbatim.  T=
he IRQ
> > will arrive at fep_sti_start, because RFLAGS.IF=3D0 from the CLI at the=
 end of the
> > ss_start block, and remains that way across fep_bd_start.   And to make=
 things
> > even more confusing, the IRQ arrives on the CLI even though it's in an =
STI shadow
> > due to #DBs not being subjected to _STI_ shadows on Intel, only to MOV-=
SS/POP-SS
> > shadows.  I.e. the #DB lands on CLI, pushes RFLAGS.IF=3D1 on the stack,=
 and then
> > the subsequent IRET from guest_db_handler() fully unmasks IRQs, and voi=
la.
>=20
> Yes, the RIP here should be 'fep_sti_start'. This was a stupid mistake,
> and I=E2=80=99m very sorry about that. In my reply to v1[0] I explained w=
hy an IRQ
> handler is needed, so in v2 I added comments and an additional check,
> and I tested it before sending. However, it looks like the patch differs
> from what I had locally=E2=80=94my code management was a bit messy.

...

> I have tested it on both Intel and AMD. Please let me know if I should
> resend a v3 of this patch.

No need, I'm actually going to send a v3 of the entire series (beleated fee=
dback
on patch 6 incoming...).
