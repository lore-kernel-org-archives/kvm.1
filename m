Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D844334C0A
	for <kvm@vger.kernel.org>; Wed, 18 Feb 2026 14:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424954; cv=none; b=JcSiTUczuOwkzXwS0i3PHo/MLkqbgQ3g412FuZzvX1uLR/fUNVAMkhSnaQylsaKkinjubmXcW9SbC44PKCKOi9EKg7cYHOhJWoQ0SSwoyWOMpe6Qrbrp/f0bN7U66lYAvWSPfvEBWpSp1wwdqOS7ZzLYXAkN7k33UoXuOQiIQZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424954; c=relaxed/simple;
	bh=IRBQndA03HmhOZxNpi9Cu1G1MHrDVhLuavMjYLrYIZU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qpZzTDwvfdPz5/NC2jR0X5jkl5lCBqJCddXVAj/PclSAqP5eT6Edh92gKAQM9/XbaKoeyVbYXtv2xmUWJqPRF1XzmTWGaLz7FmfemTEZdEj2qlSW2IGlHONn4eZ0yqyBRXvciRgre34RNAeI25LOeeo8hGR850yUsdX8eyCWvso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DAiwtb4o; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DAiwtb4o"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2aad5fc5b2fso58108595ad.1
        for <kvm@vger.kernel.org>; Wed, 18 Feb 2026 06:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771424952; x=1772029752; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJeuFVbekGNTo9ZbL6yrJVWhF0vC+VBsyIOWnUV0wG4=;
        b=DAiwtb4odMlDkFp58OGhsiPpK8n+mkWttigqlzHELmnfxIVb1iqJgaC6naFiznYOQw
         Fkv5pKR05FdPd89c4WOZm8S9wmRBzOw+8O5yrPSZacA1ApZEIrNnfDe6npcEtoCUt7cA
         ZCZWrZxBrYLS1WGo0Ow3z9/H5OLovgUtFn7Pk1e5nfq1bW7ppZmK3DbpvOWJF4NHvELn
         UQdfMqseiDi39QW8372fVhU4BW8Z6zZyOR2I+g71k2nWRnihgY0T5JeKAZqROVCBX76Y
         GPKlVmyWpE0FA5ETp8FepMD8LkcFyBGFYj3w5+4RwY1bIOh/JXIhBK0acyni7bbDo8zg
         wv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771424952; x=1772029752;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJeuFVbekGNTo9ZbL6yrJVWhF0vC+VBsyIOWnUV0wG4=;
        b=Sr+6ORe6PCZLx28aD7pUbrCprlG/jJatJ9zDcCOC3xy0+ASkX3mRwbItiBIHq2He/9
         3J7V467DxEUczg4U7jThCJooCPbm6y+sC8y6vWVLE3ymWbzhVanwYvPOGaTN8Jq3C+Bx
         EMkxnOyb+Pne3Le2w7rqaaHzEkDk4XlUQVd6OGN3w5AM6c+DkHbl+QJewwEs8JkmlaA9
         urqrut02rai/LGgh6H8oeA24Sf/PMMwTleDAJtEARlcUHnYs0UrcTu7YwbSjZekKWAxx
         WXcQXbIA07yhWJ6WvvjljeiLaluS+/2QdmIcUmN+pYbAm6tkwXSiQmnfCw0cqddMozda
         9oBw==
X-Gm-Message-State: AOJu0YwreRU9jhEUocds0bhrReTOC3cs521FNjHZ8MkbbDCPQG1VzNo4
	gWUtBid29DFlfjYJc++FqT2WzhJcEhGN4LVzqx4AFk2i8sDJaRlyyEPLuR9wIBZJYxvtdDi7mFx
	163G9Qg==
X-Received: from plch7.prod.google.com ([2002:a17:902:f2c7:b0:2aa:d7bd:1139])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f685:b0:2a9:602c:159
 with SMTP id d9443c01a7336-2ad50ebb14cmr20825435ad.19.1771424951473; Wed, 18
 Feb 2026 06:29:11 -0800 (PST)
Date: Wed, 18 Feb 2026 06:29:10 -0800
In-Reply-To: <330ed8d57ee5c7574d7bc1b637598bbef5325ee4.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260218082133.400602-1-jgross@suse.com> <20260218082133.400602-5-jgross@suse.com>
 <330ed8d57ee5c7574d7bc1b637598bbef5325ee4.camel@intel.com>
Message-ID: <aZXMkWRuVE_efHUW@google.com>
Subject: Re: [PATCH v3 04/16] KVM: x86: Remove the KVM private read_msr() function
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jgross@suse.com" <jgross@suse.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 18, 2026, Rick P Edgecombe wrote:
> On Wed, 2026-02-18 at 09:21 +0100, Juergen Gross wrote:
> > Instead of having a KVM private read_msr() function, just use
> > rdmsrq().
> 
> Might be nice to include a little bit more on the "why", but the patch
> is pretty simple.

Eh, the why is basically "KVM is old and crusty".  I'm a-ok without a history
lesson on how we got here :-)

> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > Reviewed-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> 
> Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Acked-by: Sean Christopherson <seanjc@google.com>
