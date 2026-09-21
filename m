Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61504A2E32
	for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999600; cv=none; b=luG6h5B4hU0fKwGxU9s4/25mXYcP1PSRrm192SG8d+7lcf/Ixm3Nn4pu+3/iq0M71dx0mlQyNjxl6l4IpvCCIV1T+xCPDkozDzNdbxMkZs3waHoGGz25EisjBD5foZk+i2T+zONsJmybSdH3Ym261I7Jai2EE6B0RexifrN0i/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999600; c=relaxed/simple;
	bh=A2LrtQ7ZtBWMR03+zbci/R9MzI5Pc2F2QMHjFZMlWAU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mBhFQ2fEdwYy/vB2kJgl2buRD0D9oGcx3JuOTBQR0Ix9ZijrgaO9r78Dpel1jzR07wYox4Ea6EfhmdDOVnBWxxRzffXyK21LU0OOuOZf+YMQ1EYgqxE2KxYoUqbM41tt7Cn9pOpsr5riZA0gbt6px0Jf2afMWIC+v/kgo/l3PKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OCtmNoT6; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OCtmNoT6"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2dd188e16a2so34033405ad.2
        for <kvm@vger.kernel.org>; Mon, 21 Sep 2026 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789999598; x=1790604398; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i/muhDVYe/u/0a8VSASygMA0PeAhT5QoDIzy8zL1loI=;
        b=OCtmNoT6uKHszyBLCmdGVgtz4gbWl1Gh+5iiscbZuc1Kp79bZqJ3UOrhHqd3ezjG3s
         kzP3E/q0JE+k/HnwiU5XlpNKMXlenXATWlfZv3JOqY99ApIrfw1XJmeDZqOKKA7dI4rb
         hYSI0t4niNJM9+8XFuAtVQHa4qM2s7fbAMmudjslW/XNBYIy8N2O+JpSPu/IzXRh0E4I
         gxhapg1f0+cEL2uyOudemkaL+K/PHOXsRWw2tyzgEWfw1UyGnVcOTfPGk0cgsx14cO+g
         /1ktYqoSQxjcqCvHjU6IZQ2iiMaAmSqETbSy2omTD734QoIiZjNQBbFnvElczS/1A7CD
         AJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789999598; x=1790604398;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i/muhDVYe/u/0a8VSASygMA0PeAhT5QoDIzy8zL1loI=;
        b=erCtDARzTvfI0yMJhX88JI3Nv+vp1QOPZScg7hU3yPQoLCAve6DMHehDPvS5mv866+
         3Tr0v1NfzlBulpTQTt+czbST1tAwY4vTlg0lZZPYrk1ew6Tv1268FkPWRqrsUg/r7bHX
         Yu3CM9DSYx/uRJJ1bO+F/3amwaDoKgcoGlWzyaYK9mBsqgVmCECBWNRDFfnylJ82KQEU
         7rmoPiAcW3iouXLvkl3wTQ2kdxZAm5824DsbZNjNFejNqyQlYs9/6DhONpCkeO96dDoy
         lgwchj0uM/WZgjRG8M2/wiQN0ZbR69bXuoEx9kk4y/fKM2/81Hd6NiZ/K/IbDHeaCvRh
         Wp/g==
X-Gm-Message-State: AFuF++lfytyG3sX7KxBfXKqtptJxmYJEpRy/JPX2usRn53F/4clcuBNg
	7AFvFiVc/vAyfZI893+vmXi25M3m3C0idSCb4AmThfgdzJJ0mcMv+sc5Z/eV1RrdUUvnD+V5j5K
	4f/dOWQ==
X-Received: from pltt2.prod.google.com ([2002:a17:902:d142:b0:2dd:86da:afaf])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2349:b0:2dd:c100:4b73
 with SMTP id d9443c01a7336-2ddc1005ee4mr92173005ad.42.1789999597950; Mon, 21
 Sep 2026 07:06:37 -0700 (PDT)
Date: Mon, 21 Sep 2026 07:05:18 -0700
In-Reply-To: <20260827112200.866476-1-zeng_chi911@163.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260827112200.866476-1-zeng_chi911@163.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <178999879184.740271.10237391317724062011.b4-ty@google.com>
Subject: Re: [PATCH] KVM: Mask off the address space ID in kvm_set_internal_memslot()
 check
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com, imbrenda@linux.ibm.com, 
	xiaoyao.li@intel.com, schlameuss@linux.ibm.com, 
	Zeng Chi <zeng_chi911@163.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, zengchi@kylinos.cn
Content-Type: text/plain; charset="utf-8"

On Thu, 27 Aug 2026 19:22:00 +0800, Zeng Chi wrote:
> kvm_set_internal_memslot() is supposed to reject memslot IDs that belong
> to userspace, i.e. IDs below KVM_USER_MEM_SLOTS, but it compares the raw
> "slot" field, which packs both the address space ID and the memslot ID
> (as_id << 16 | id).  For any address space other than 0, the packed value
> is always >= 65536, which is larger than KVM_USER_MEM_SLOTS, and so the
> sanity check is a nop regardless of the actual memslot ID.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: Mask off the address space ID in kvm_set_internal_memslot() check
      https://github.com/kvm-x86/linux/commit/7d2a727f44d8

--
https://github.com/kvm-x86/linux/tree/next
