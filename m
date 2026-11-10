Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271849;
	b=zPWaZtVu77kKc04++tGtZY+AmiZqDFUGXKv4TAf7LWKIwu6RelRY8Xs6Y88dqkDxYnFu
	 XF1d8jUy0jag1B8w8zrR7KKyGqlBeFj53Cdm1Vo0dMhM90wiQtn5CNQvQjXOTO9W+X3fc
	 qLcFgdogNs7rd8es1PIeK3tjWkqSTQdYTg5RGDly4aYq6VGX9m9CcisNMgxR4IRdtpSxJ
	 pOJ6Ya0zBPkSlPAivVMxEUPOCGBbNntC9XB3FhsNXasIZ/cBQoFAMgKDqqPFePml9PFV9
	 iGIZ23Q4YAKHrvuorgjDZe/fCJYevW7pX0OO24b/VV/8ilCoQtUZA+3azAQfuxzFWKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=9aUmjjXy2UpFvwIaZx+Kc6emVkBoaRCWFUjyBYUuXe4=;
	b=4tyrJuZYMUEziLWlSUrEMuBOUrz9FgDaky2kLjS9wKybXlaw2xgpqUv+1j/b0hEXP74U
	 f1baJgsNA0tialqZJOaifFIubXueqmNPo1YWP09CjsNlXLFRHUwECeA+yeK/C+6WyhtdE
	 psCPeFen7/nvQCPCPWpAmorteNfZDqjuyHQXzF9tYBewwuSlAJe2XYZTyt4KqRcyNGwLh
	 STcTFVHfluTZHdE1EYq0Gdkg5gD1Lp2uftjlwJCQbz56bUQqtvyEEtJZP26nA3E9AghyG
	 ncnCgtsEPl/gorC0BhmqFnFyTY6K3MtTeOL0O8RLgSy/y8BO4KNm+SH5m19MkSi+cFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rxqy6ixe;
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026DE606A330
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 00:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 026DE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Rxqy6ixe
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cdaf2073b0cso862474a12.0
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 16:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794271848; x=1794876648; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9aUmjjXy2UpFvwIaZx+Kc6emVkBoaRCWFUjyBYUuXe4=;
        b=Rxqy6ixetikDYH4GXTU6DVlNgIzULph56hr/ylPgKBEq0LAlCxBeqtn3zqJLm8xcn9
         /8L8gEpu0FFua1AhJKLHLRbGekFetzUJMpAhLvBkyd6Io4I8yVRJ1QPbOdpOumJxKtNh
         oMHHHRmbLW+xy9nfrbL3O/Y/GIENxUCBo+qprlcK5nHvk8Mf74MAkBQAagwOLqXMK0gK
         01XQLwADmqO9ZRtOrPv4jag12vYH76y4TtBVV6TFN0ri4rMmBiFegEp+AZT1vNUQOljj
         UCk05FbvXMpWSKjhnKf5Yt/0k1VwOGa3C7NyCBNMU6nsHzQkxBdxpMV8/sXi1UpwGU7s
         PIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271848; x=1794876648;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9aUmjjXy2UpFvwIaZx+Kc6emVkBoaRCWFUjyBYUuXe4=;
        b=qNyHC/xFhfUe9P6arZl4pfFaZeU/g3aICwUIlOouFQACWBT8EPl9FU/z22Wx0vnS6u
         xiZbMw/V7XbzgoQKhwXooSrZtsp0kPKJzWLR/tYGU3DCpGBgG3z/14e9ZaHGdZtumub0
         i4APDHYE3u84iaqk+ebpykgAYLmTZofUEu8y6lsjlDVmS1AtJwjiUg/UwuROB88P8f4u
         Pec1zNtQsMLmC16d7UNSnK2U9sjcIMVfgCYoTIyt18uq2Js3APOP25rAaP4Mi455A1ow
         fKdpOgLHXNu/bmPQzlAKyjo8ZP7unbnBBsvxVDDZex7ehwmTPv9d16aJWVgIk+dCC5R8
         +5sA==
X-Forwarded-Encrypted: i=1; AL+hErFdxnf/ZpNBqtFQ+/M4bo4MBlvWGeX7VvRCqAvaxlswDY75pky+4RlqYD0/oE8YBoAL/k8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8PtKgpav624GrD4C6A+zfxfhidPG0mJO1QO8vxDskcJAxByt0i
	FnrKQNpkUEdLit5Gq+YmBF7MBQHrvUiYfLzncCVMhSlQHsH6lPMxe255SzsPMN6nGmicVp+GOAJ
	Zp88nqQ==
X-Received: from pjdq9.prod.google.com ([2002:a17:90a:2e09:b0:3ad:32d0:ca0a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a48:b0:3ae:898e:a123
 with SMTP id 98e67ed59e1d1-3b166cd70c0mr1265220a91.14.1794271848067; Mon, 09
 Nov 2026 16:50:48 -0800 (PST)
Date: Mon, 9 Nov 2026 16:50:47 -0800
In-Reply-To: <CA+EHjTzaJx2nV_9YEExgYn7STSP1Kvhsqan8va8M7ba4WtCiqQ@mail.gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20260922071945.693714-1-fuad.tabba@linux.dev> <20261007074037.316564-1-fuad.tabba@linux.dev>
 <CA+EHjTzaJx2nV_9YEExgYn7STSP1Kvhsqan8va8M7ba4WtCiqQ@mail.gmail.com>
Message-ID: <avJqZzKX1ZVAMGr-@seanjc-mac.roam.internal>
Subject: Re: [PATCH v2 0/2] KVM: selftests: Fix incremental build dependencies
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Oliver Upton <oupton@kernel.org>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, James Houghton <jthoughton@google.com>, Will Deacon <will@kernel.org>, 
	kvm@vger.kernel.org, kvmarm@lists.linux.dev, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 09, 2026, Fuad Tabba wrote:
> Hi Sean, Paolo,
> 
> Another gentle ping on this series. Is there anything else you'd like
> to see before it goes in?

I'll grab the KVM change, but I would prefer the cgroup change go through the
cgroup tree, even though Michal already acked it. AFAICT there are no dependencies,
and it really has nothing to do with KVM.
