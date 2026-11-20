Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198471;
	b=oYX0GGxkNvQBWeSwkwFMZKGjZnWCXvy5QT016Lkg5UpNv787BviGb+VBGyifZGac7UdX
	 PaHqoQL701H+T0u9Ir0tXk6t8mKgwb/0WmawmhnJ/u72gcaJqleM+DEYKe2LI/pQm9gQL
	 PIREEDO1YMSwslLNJSFy2OZd4qBi3JhrS0wF/6DRUxH+ijX2yU7zBL/Lz5q2aSJFiUJtS
	 Z0A+tj07X8gZrlLLPwD1xzXZKhwZUTFe+WeY4Lm4E5HoigBcuJ97phlihr8VEyz4HrGfR
	 AjMZe0k6CgO95SWKmNtz44/b8lbGSNfah5SiYyqqQ58OiKKMdZlA4W8beY//5eiDwJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198471;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=y5c2VZtwDRA4u4fDXfCjcUviG1Y5Rc9cZO3OfEME5lE=;
	b=wZEuBjSSLyQuneLKg+cJmmrpRkHk4qRwTvgNEfa9iUFC3xPbwpVKWuRpGaXgCc/doA06
	 BO3jEUkN9lVnSg1abGUPeDoBW1x1lJAkTucRLCWO13RThg1LkX1V/meRCyWMJxL6qiL7u
	 q5jgsU9TAN71/UEQk/m34jVRihLfYxhUdvFvcL3BWkAzw8cH2pZVfkJ0MfndXQvr6Vq5S
	 3vNNunbGf1cHYWhpzoQCIpEU+oEC9XHHdxvNY+wyKIcSdIr41WYioVL7nP8fNFU1zZIJr
	 FBYtaq5np4i9mYk+6Dilyn6jdqbEK92SXq/NF8Uw8DNj8uGBOT+zaU4C6uvt73h1gGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tu4rEJsI;
	arc=none smtp.remote-ip=209.85.216.69
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C2606D4A5
	for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 18:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A27C2606D4A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Tu4rEJsI
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3b4092b645aso1271145a91.2
        for <kvm@vger.kernel.org>; Fri, 20 Nov 2026 10:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795198470; x=1795803270; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5c2VZtwDRA4u4fDXfCjcUviG1Y5Rc9cZO3OfEME5lE=;
        b=Tu4rEJsI9U/ztyWe6nHOylhPszZrrJOATOtwxO7XPvvJIrMzuyDwriPkZG4qC2cfd1
         AG3cpI3Z3jOf9qqxXV7mgCVNO2YrFzMKt58Q8a5YXkzhVljAEb0bzrkyHc2q7Joku38E
         rRPjsD7pOK0incNalVTldmhyXFpWhbIjepmfATLjPMcKw5ogWGf01eJ90vgOZ5rf8nX1
         s7Cdr/rbewwFO1k1JDEEAFrLa+v+eng6y2Kvxs0jd+siZkiaSPeGSJLr7AF7XyM6IixS
         lUgh9MHKiFZ+wH+P2ZHzY+pXx4EV0YDNZZmFi9Vt5keH9hLDqh1Xv7BxMcLPSAaMHB13
         8pKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198470; x=1795803270;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y5c2VZtwDRA4u4fDXfCjcUviG1Y5Rc9cZO3OfEME5lE=;
        b=b2kASC+rWKU/VcvZdAXNuuElRIuaA87kOmCPhf4Fs1DW9rDpy93bJ6N4o9zvPqfX7s
         Xv1Aus9rgf8mG4LsZa0E9LDh2cglhtZBYMy6coqI3mSO76SrkNZJ1asnAOjegO+EqF0Z
         GRNnwX/icfHuGP3xv/wxQeZnfZOqIA25Vr7c+crl8Uff2AYJvXXNSgpqz6KNF1CSpvB4
         aKlEyTHpImZ62GrGGPwf+sZ7+yOCUXbHflAbIgUMD8j4vsyvwl2opHZ9LkDw/IfdT6gS
         yQ2MR3OXvfXnHdTEBZbT1xYftyAtqKtTIcTFSXUrf982kSPm8yRGKqJs/bNdS2uk8sSh
         eqeQ==
X-Forwarded-Encrypted: i=1; AL+hErE74UCyQ9twu6wNSZagOGhSOmLj4VkgKCJr9ufEe8yYsirQ63BU1Dr5IYpxvV71i4SSvlw=@vger.kernel.org
X-Gm-Message-State: APuU4Z80E6hvMIps/zMm38pzbUnfY7vHUi7KeyPJcXGC4I94Wasnn7wY
	aVsqUlYUeiukoCIVhD5r6mnffWBoQ3Z/rJ4QVOzw4n9YxVI0chbIm+03dDf1Do5ZCl0H2I6ES9E
	cWuLlvA==
X-Received: from plcu11.prod.google.com ([2002:a17:903:308b:b0:2f0:2039:7919])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f8f:b0:3b0:9bfa:72b1
 with SMTP id 98e67ed59e1d1-3b41c942d13mr3794872a91.49.1795198469813; Fri, 20
 Nov 2026 10:14:29 -0800 (PST)
Date: Fri, 20 Nov 2026 10:14:28 -0800
In-Reply-To: <20261120012553.3745742-1-jrhilke@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261120012553.3745742-1-jrhilke@google.com>
Message-ID: <awCOBAeHtPf6emcp@seanjc-mac.roam.internal>
Subject: Re: [PATCH v9] vfio: selftests: Find devices that have VFIO selftest drivers
From: Sean Christopherson <seanjc@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 20, 2026, Josh Hilke wrote:
> Add list_supported_devices.sh to print the PCI addresses, names, and
> selftest driver paths of devices on the host that have a VFIO selftest
> driver. Group the output into sections based on whether vfio-pci is
> loaded, whether the vfio-pci denylist blocks the device, and whether a
> GPU requires an architecture check at probe time.

...

> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Josh Hilke <jrhilke@google.com>

Output LGTM, but I'm most definitely not going to try and understand the bash
magic :-)

Thanks for enduring, much appreciated!

Tested-by: Sean Christopherson <seanjc@google.com>
