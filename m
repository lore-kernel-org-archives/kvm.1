Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.219
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331941;
	b=0bZuifrMaO6B0npS+ULDLkXIyP3TkTCBqWKMH/5snqq9aboWoIeBSz6SqJkgq78ZSF+V
	 LSs7uJo1PxWFtzNmX4HgzR7PxAvzZTeIhQ2YXMo9vE/OD/aJbxcjD/gPwBG1zWuALNW1f
	 Znn8HKxevm0Ms+8j8NvG95mfAzmwSpkm9J9O7UufiCG+Gqj+uq/XBc7SjZDd+M1jvpXEG
	 8hxLzvnDXk3b1wKa04sUAy3tG7+w7jr5omqDAu+wvGNy2gXrFokXSe6mGmMnchHJlcNCR
	 /Vb6H14jYJibKxIlI6UV4YWQz8kiebfzsJw9odh3zLo45DzKlMfvZkc7rMljCkHYFqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331941;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=O/wNfj9zcVudY5TorfEHZYOP0zrjBm5k7fCeb1ImJL0=;
	b=xNBmBzfjF378Tm4c+1kGPkgKZzm1BLcJB7hwIXmFWNekxSku2DMnbbfqiHL+df/AzM4u
	 yr19VFI/kqwGDsN2VCqpGavfxkA5+Ep8g/loBRRUx5719p+A1FrY2nYkBgToqnhztB/7C
	 9S1y5EvHCmRT+8KUl9l8FneF983j18kcXT5M9r3osQfDJmTnrhttWOCc1mfRAQOBQh/Nr
	 JBPHhXq9d0f4i3PdxZaXOc2Om4Qe/sL/d2ynZ0/U+KkHRdhXqgLdO+u6teqrw7FXnxUu5
	 hWPKwwPCWmuUheOJaXoOaFruDavJkJuCrRkoa+IPuveINhE+7c+zDEYyrDqcOIflZIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VbTc9xnQ;
	arc=none smtp.remote-ip=91.218.175.219
Received: from mta0.migadu.com (out-219.mta0.migadu.com [91.218.175.219])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAEF606A320
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 17:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DAEF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VbTc9xnQ
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=O/wNfj9zcVudY5TorfEHZYOP0zrjBm5k7fCeb1ImJL0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794331938; v=1; x=1794936738;
 b=VbTc9xnQM9DC9RHCUxtKEZO45jaXKNjVl6mGg/xr240xE8cKAkAyBgjDNIE6F97Pjq5oiuhq
 NxpwH2RY54o5Gxr1nhxz06fszpg0+F1JDz0YY1yGnV56MFJ8vPRYcEq2jA/Hsp91ET9otQceje4
 BsTB8N/147EaxZii2vg/AOOw=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f0ddaba033ae0cd3;
	Tue, 10 Nov 2026 17:32:18 +0000
X-Mizu-Trace-ID: f0ddaba033ae0cd3
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5c144eb2f43so6228e87.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 09:32:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHYxumQRD9pbLT/Q768I+ANQyHJ5QVoo5ClGL7cYFl69/Yup9KUgZEZZR1bwZqDj7ivXrg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+U9NFcJZ9eg/DUYss7pWpkRqbARZsYVFt7ta31oC7prW6ZCN5A
	CWj8iqi1RdFb6IbgKnWhow+QNal6gzyinX6sZK9hsDmBzpEnsDMPCc9d62Sj7vL1m99fo3M1a8U
	tmvmQ4M1QyYtsN0jLqf5kGAF+oDl5P8NtoYO7i2x3
X-Received: by 2002:a05:6512:1052:b0:5c0:7c6e:4559 with SMTP id
 2adb3069b0e04-5c157db2ba2mr166549e87.9.1794331937194; Tue, 10 Nov 2026
 09:32:17 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-3-fuad.tabba@linux.dev> <avMoubwqgXbpflwM@gremlin>
 <CA+EHjTxT_9NghyLSZmOOi_oQboQw-g+6z9WxwaF=-7RdaGbMNw@mail.gmail.com> <avM9i8xWNZ2fU8_2@gremlin>
In-Reply-To: <avM9i8xWNZ2fU8_2@gremlin>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 10 Nov 2026 17:31:40 +0000
X-Gmail-Original-Message-ID: <CA+EHjTw-t85cJcZChnuEcTboe9FbLmvFXi+vn3os5N49R-z33Q@mail.gmail.com>
X-Gm-Features: AclHuK9X3Qq0RyJZlRjr_WD8VHNxqnjWuSAxxr9VQ80XC2fWGGeURk5VvSDZtkI
Message-ID: <CA+EHjTw-t85cJcZChnuEcTboe9FbLmvFXi+vn3os5N49R-z33Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: selftests: Test KVM_PRE_FAULT_MEMORY against a
 full dirty ring
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Nov 2026 15:57:37 +0000, "Lorenzo Stoakes (ARM)"
<ljs@kernel.org> wrote:
[...]
> > Yes, the acquire pairs with the smp_wmb() in kvm_dirty_ring_push()
> > ahead of the flag store, and the release with the smp_load_acquire()
> > in kvm_dirty_gfn_harvested(). dirty_log_test does the same.
>
> I know it's test code, but general kernel practice is to add a comment saying
> what memory barriers pair with so it's easier to track, could you add those for
> these?

Sure.

/fuad
