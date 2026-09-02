Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22D537BE6A
	for <kvm@vger.kernel.org>; Wed,  2 Sep 2026 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371621; cv=none; b=ChZmnAZywUHXH+rdqB3qa1dTsv5C7+Ulx+WW66YGHe4bwTZa/vMCeXSlWJZALXAKIw9K48LwK+IO7GrZ+F4TU1iohfnjN655UFc1B51/8upB3TjLc9HCcpW0iov+e/1FvN/MbAhfzAghSv2efbY506N7sp85svUun4XFihrv4UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371621; c=relaxed/simple;
	bh=b5kh2R8Hzwwj57HzVfabs/YOUfR+MDkcYfNrpEGQb5g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Hhoq2+hAfk0pMQxJYchFNHzg7gmPJi/sv76N0jdRDKI6NXJp830c0rKJq0WKxtFlK8fne71zxyo42TpvfZ/iNY8rrkJH83UrMEbdf4XquG08gz2o95uswsLIViSlG1lSR7N85AdFjs2YVd/20nuoo0DYze77V1zZlHJBfvCcK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/bLSAtd; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/bLSAtd"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-855315ccb64so1214808b3a.3
        for <kvm@vger.kernel.org>; Wed, 02 Sep 2026 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788371619; x=1788976419; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SdKJUU1oimzE531v2SlLnET8xKOYeS+3soklD8mAhs4=;
        b=j/bLSAtdq5MLbOsrFvQTaU+QttTveQyIFb++hjyQeK4dr1+sz3VIgUAUx8ed6M4OwF
         AckfeK1wbLLCgFBsu/Tj3Fshclh+viV4d8lKH+HDcceqwBXu38f7JDTACw3XkZ2qeK/z
         kaCeG6iqe8Fc/n9WmDU8htbVU5hoVutp7feAQxLPq43ew1R3SR47XR6/Xq6u2oXGZgM5
         AWdd6zdWunHAZKLJlfASmwe5zUWGttFGuriI1dw5LUd6PdDUd6JJPivPG4V07iWRRpUs
         3pjcatvzwtmHpq2b8B4EXyjOzjr7omtq/P5tHonRaSmi+yl4NUQPlkwkDvl9MSWB9i+K
         Gy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371619; x=1788976419;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SdKJUU1oimzE531v2SlLnET8xKOYeS+3soklD8mAhs4=;
        b=bnVft/SUftCToZc2hjYXnro+3gSpwebYTWnIpDcgnli0ZjvKJWmfMs0jSzZhIOF0tZ
         GPVoNls/W/OJL3Jz1QiJG6LYFZub/85psuMIy/JaMfJoP7J8Zpzw9htahpYZLMRWzw+W
         TRlcpOr7D7a2kMTCUePO6Wa/03++2c3JtJA7E/zveaX90n6pIHsCKxt94HAzazAtVTH4
         PSM5RD/QVqHr2WUzeXyoK+V1jn1zjHYfqL2FmlzMchKWu8Fu2huGRjUJISDbTX5txlu1
         QHp9fSbpJPFZqysvChyBdhc7JvmvHTivdhyoy4HBdX0hAGmMLvLvuX/oBBu9hcdGahSB
         Yccw==
X-Forwarded-Encrypted: i=1; AKwUvBy7HdtS94O2oMIA8u3RIcwrxQqri6CDJ2V6vOQId26xbWlID92/mMGWhatkhKcKtFwdg2A=@vger.kernel.org
X-Gm-Message-State: AFuF++k/QYny7Vl4S+9gu3q22omgHbebX2GTBQea7yp3bsDpjOfa+mIc
	5o6ECql8QFInzxhxy7PpnSUxRv2eXsPseQu6hDZy2FyKaIxg7kWjfXNAZeTGdQOM57j7kBjS38v
	4l5INOg==
X-Received: from pfan9.prod.google.com ([2002:aa7:8a49:0:b0:842:83c0:8d73])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:440b:b0:847:9aa8:d3ce
 with SMTP id d2e1a72fcca58-85ed1b0e821mr10816352b3a.2.1788371618918; Wed, 02
 Sep 2026 10:53:38 -0700 (PDT)
Date: Wed, 2 Sep 2026 10:53:38 -0700
In-Reply-To: <aphhKDm7Vx7G5ivr@Gautams-MacBook-Pro.local>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260826230511.972824-1-seanjc@google.com> <aphhKDm7Vx7G5ivr@Gautams-MacBook-Pro.local>
Message-ID: <aphioo_KTboUCtZd@google.com>
Subject: Re: [PATCH 00/20] KVM: selftests: PPC pre-enabling
From: Sean Christopherson <seanjc@google.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Atish Patra <atish.patra@linux.dev>, Alexandre Ghiti <alex@ghiti.fr>, 
	David Hildenbrand <david@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 02, 2026, Gautam Menghani wrote:
> 
> + linuxppc-dev

Ah, shoot, I *just* posted v2.  I'll add linuxppc-dev to that cover letter.

https://lore.kernel.org/all/20260902164123.2546762-1-seanjc@google.com
