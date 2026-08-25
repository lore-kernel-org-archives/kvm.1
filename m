Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511F9345EC0
	for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787680124; cv=none; b=f9sFdgnsZcPaqIlhqLwMKq66fL9ty7O6w3enV7MjFRMSY3/gAcMRAali+BkxGNHCnF1Iy9NK4swzLI6Jki/WWpzEQEvn5e0h2/OVWsogPr95vzUbklbZBBwQGpf8N0IHGhPirmtfxu6SNbBnmCkQDMqP9BGZzLwxn7BSw8ft8Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787680124; c=relaxed/simple;
	bh=c4O1YuM86p+GvK8W1WI4s9QhFG6ZLMMG+9fo6oalN1k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rq+M02624VezxNc+VVszr+UN9XCPJQkr/Xmo3KRYUkXCrYABZiuIoY9fgcKRyj6svxp/rcYQLAM/Y2C66eG2w8xXVgQar0fa00UDj49ThiLBBp8AYG1fbeWeVI5Uv4W0YymNghgLbyE/1BXhzRPiTUWdn45N6pNjckJhTnRu7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kz9chFXI; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kz9chFXI"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so3120a12.3
        for <kvm@vger.kernel.org>; Tue, 25 Aug 2026 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787680123; x=1788284923; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LfNdtxjurrpQVrdCO19VGPq2Y4QeRrOBNLADjxjp0d0=;
        b=kz9chFXIEkGx4Sf851xZV95gl/qyzcgM2yUhzw40rm0opl/ky9EsS0Vj35+hKc1McA
         LcKNbOLQ8eVJtroCDPp+jmSQr/RYlmfRphjV96BtKXg9W5ptGlGtS+IKWV+a2gOWFRH3
         rtN2KYQWnsg+8fKbCtn8HGwE4tZQJKHSDxACcW6QUdmiNjl0BB1plEgBEtAcmVRJur7Y
         cVPWjb4OzVzkxBHuOQVBmZHCtOFu1Dr7jvYm7ZAMze8RTu8IOun1acfEzui9uT9tP6QA
         YSDQfRMrKNzT8ooALrb/G9Cq8nGLBzQoD4RC0itLx+n924MARGLV/UWuvOtQvQGp7WHk
         3BTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787680123; x=1788284923;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LfNdtxjurrpQVrdCO19VGPq2Y4QeRrOBNLADjxjp0d0=;
        b=UzWoItf0TAPjt4Q8AJfrLBBO2O88rUxx6DXWIQsLl8rjJS/hgP+M8rd4Bmt44wgSj9
         0BqBgYCZRT1Vzxzuuw+mFkF924cNgNNWEp7hvld1C8zDVw323D1+WUdsSfLD8CS3UicB
         Ib7uMZkB/oGdx7Wi2PEzFNMjfjgEu0yFrSLctxzXCMzuh8bf4XVJLstvotH8qbkw717r
         nQrujuxM2Lbq69NvHOaTzL+LzqbI2tPE/D/D9YB1XSFmcm7CAUw4I92O1KFcgDnghm6g
         P4IPehhFfAKYRgUxn0lyP8LwJNrvv01ftE68jrRiHK5ArbftXhcOUxAXeQ4JYUI331eP
         4j3Q==
X-Forwarded-Encrypted: i=1; AHgh+RqANRouU4OdosFJVRlb6XjlaDCC4hOFb98P/HEnh5NCJLqrDw5v0lYFH9KLfyzPqkYVePQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nBd6v7/h+kVHqixj1Ej92ZAYDGow5cYMrRvk3irfRXPqhwosd5
	yCwQKkOa4jQ3BHVfOpYfcs38ysZ+0Q17bkR8SbScaDIRO22CZ6PZNoXoD3Uh/DU1D2n6eDMyn8w
	jcIRi0w==
X-Received: from pgbbh9.prod.google.com ([2002:a05:6a02:209:b0:cc1:b199:ca6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6ca7:b0:84e:24df:3870
 with SMTP id d2e1a72fcca58-8536ee112damr1011928b3a.0.1787680122302; Tue, 25
 Aug 2026 10:48:42 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:48:41 -0700
In-Reply-To: <1f12e12f1d5e7baed6630fd15cea5420c40ada68.camel@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260825025533.25663-1-yan.y.zhao@intel.com> <1f12e12f1d5e7baed6630fd15cea5420c40ada68.camel@intel.com>
Message-ID: <ao3VebUyMVlK_qGA@google.com>
Subject: Re: [PATCH] x86/virt/tdx: Warn on !4K level in tdh_mem_page_aug()
From: Sean Christopherson <seanjc@google.com>
To: Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc: "kas@kernel.org" <kas@kernel.org>, Yan Y Zhao <yan.y.zhao@intel.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, 
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Kai Huang <kai.huang@intel.com>, 
	Dave Hansen <dave.hansen@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"binbin.wu@linux.intel.com" <binbin.wu@linux.intel.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>, "sagis@google.com" <sagis@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, "bp@alien8.de" <bp@alien8.de>, 
	"tglx@kernel.org" <tglx@kernel.org>, "yilun.xu@linux.intel.com" <yilun.xu@linux.intel.com>, 
	"x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 25, 2026, Rick P Edgecombe wrote:
> On Tue, 2026-08-25 at 10:55 +0800, Yan Zhao wrote:
> > Do not drop the "level" parameter instead, as it will be needed once huge
> > page support is added.
> 
> TDX and coco has so many plans for the future. An abnormal amount of concurrent
> thinking. I think everyone agrees we need to wrangle it by doing things
> iteratively, and cheating when it comes to uABI.
> 
> Since we have TDX huge pages coming so soon, it seems ok to leave it. But I just
> wanted to say having the level arg here originally was wrong. So this should not
> be precedent for pre-enabling of things years in the future.

Eh, I would argue that in this particular case, including @level was ok from a
process perspective, the main issue is the implementation was buggy.  Which is
very arguably _because_ there was no user to validate the code, but given all the
pre-existing KVM MMU code at play, at some point we'd have to insert code to say
"hugepages aren't supported".  E.g. in this specific case, assuming PG_LEVEL_4K
could have been just as bad as having a partially-dead @level.

But nitpicking aside, +1 to not building out unused, untestable infrastructure.
