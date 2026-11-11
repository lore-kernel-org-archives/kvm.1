Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409068;
	b=qiZuMQmYcqkQ2JK2usvP0JkXfjhHnnliCSZ/UZCyS4a0QLt22ej0OdhZKarXoG6iOvOl
	 3TqjkFtNDKxjVOqIX/JY5Ac5jwSquIlzmq76J+xyABTS19kmubdSiQOxckJ7C8i76CFHz
	 f4aVW43ptYtiyr5Pv3MpaXzL1ZJdp/Q2O62VwL/cGok0gA6NWAiJ+n71Jn8GM17ojraVs
	 +NhEY/ONGKsJ3neUi2sv7sOcvqfld4UJ3P+HhnOVl2QLZ+Ekdwk5RhnpSzsSDnxzo+SU1
	 d8WvfgdlTTWLDNlVhz74vO08QQMtDPC89Z1M6WYDnP9NAnGaOSe9nolGuoJ46mHzd5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=eAVBx7wFjerY7MFoeOAbmTCOK2sMbdc2RAGG1TuVAr8=;
	b=lQC9JfJz/y0RrhEyLxXY2U7v129A1LkfA+wLS4bb+eoHPk0eTarqbvv5vLKUAXk9z6BD
	 LLC5zYYU2gSggXUsy2h1gOqkeuDOEQjHQljngfT73XEbcYpj0zWqv0XX3dvm6kExTwE6W
	 BRSjAbcUCyqFRMrw4Q/C86qAdKD0WjwgWK82UKoZyc+k9fPyERZExX4enMMEC6/IoaQy/
	 rHmOgcegWt9hu3396k8abNQKErh+tTFRwMHstzVC1dVsuTxUqo1Z0v8VUmjSRogSS6Sp0
	 BH61QJn3SdV50HHfYPQoAux7xuF3mOyOZcnmlT6lGVk3/+zXt1hvNVimh67ooodQK1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SnDZnbQW;
	arc=none smtp.remote-ip=209.85.214.199
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1AF606A326
	for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 14:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E1AF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=SnDZnbQW
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e8e16d22d8so51480045ad.1
        for <kvm@vger.kernel.org>; Wed, 11 Nov 2026 06:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794409068; x=1795013868; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAVBx7wFjerY7MFoeOAbmTCOK2sMbdc2RAGG1TuVAr8=;
        b=SnDZnbQW08z6Fo4oJucBlqSIoq6P3dVOZg3XM1Dl/02agzkA/301/aw2F7NgWhAchy
         Wrg3nXmwTrMfZdpaRe6LCOV0iBJotVmWkTKtR6lmYksyh9YQT30J1u8TqxL8NSwBEJ82
         6s+Kzx8EwS9d4JgM255tB6JnwGGEcH87zaEeSrPuXt3/fVAXl9GgdYWOXnMXxgJj/onR
         TPukIkcch7Kyq/N/MD4PSICv8FhVaHu01Y7RNzFFNpHWn1Bd+LbJy/xLbKreSZcB2Df4
         I4Mu/MsJhKxSLF0dAtCfTtLoDcVSAQFGEqPmyZj2Ia7x9yDNmdOOTpKTQnia1OnqZfqu
         ceuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794409068; x=1795013868;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eAVBx7wFjerY7MFoeOAbmTCOK2sMbdc2RAGG1TuVAr8=;
        b=0jRc0K+Ceg3ginICIMm87sSDz3nad80cjx2PYGZZx6MV7Fq/4aeMEvLvj5bRvx7+As
         9PLjXAvRDXUFUqEYKAeXL/nXl/t5F+nxVG5lxAVywbplePO3tYN6wU3nKtYNmzsN80R8
         iIN/pss6MAtxlyE9oflpbMGiiUKCj/5HaknOAkrAWBYbJYJT2XFBkXsm96a0UedDwIKK
         jiowYenVlm0IDGP2APCl+V/zyuTe7nZ1LkJNRl+neI+/VmpiRd1pKTq0Re/L6icxDDYd
         mVCuub3dC3iLUwtIQLJE3WrJ6D1o7na7CiKNFO1EmPmXJsw84Gy1ebJxWBSIZtheGdKI
         NTKw==
X-Forwarded-Encrypted: i=1; AL+hErHWIZF1n/TbtZb2ToviSVbsGhGsNYGXvL0WQFGUPeQN2sHZMIGSdF4wiC/9LB2zJ5aQzTk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+NcSZaZAP/vJIl5P5xqSgZG316+Gpp1bvgJsxkI4X7coPb3vWK
	gnInYkVRm024y62JtLzKztSERIpVX+XWdmR6vFWHNcVa0+9xSkv4l3pcVPUroPGm5EmHCtMSCv4
	/pIJkkg==
X-Received: from plri11.prod.google.com ([2002:a17:903:32cb:b0:2e9:4bf0:5f17])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b84:b0:2ed:238b:7db8
 with SMTP id d9443c01a7336-2edd7bae0fcmr30337835ad.61.1794409067689; Wed, 11
 Nov 2026 06:57:47 -0800 (PST)
Date: Wed, 11 Nov 2026 06:57:46 -0800
In-Reply-To: <avQ9Jhsnq7e3KPw-@raptor>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110110724.3614412-1-fuad.tabba@linux.dev>
 <20261110110724.3614412-3-fuad.tabba@linux.dev> <avMoubwqgXbpflwM@gremlin>
 <CA+EHjTxT_9NghyLSZmOOi_oQboQw-g+6z9WxwaF=-7RdaGbMNw@mail.gmail.com>
 <avM9_7aWUDJSL3Lq@seanjc-mac.roam.internal> <avM_FXXF9oBkderF@gremlin> <avQ9Jhsnq7e3KPw-@raptor>
Message-ID: <avSCaugZ4fRxRdpT@seanjc-mac.roam.internal>
Subject: Re: [PATCH 2/2] KVM: selftests: Test KVM_PRE_FAULT_MEMORY against a
 full dirty ring
From: Sean Christopherson <seanjc@google.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, kvmarm@lists.linux.dev, 
	Wei-Lin Chang <weilin.chang@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Wed, Nov 11, 2026, Alexandru Elisei wrote:
> On Tue, Nov 10, 2026 at 04:02:21PM +0000, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Nov 10, 2026 at 07:53:35AM -0800, Sean Christopherson wrote:
> > > On Tue, Nov 10, 2026, Fuad Tabba wrote:
> > > > > > diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
> > > > [...]
> > > > > > +static void test_pre_fault_dirty_ring(void)
> > > > [...]
> > > > > > +    /* Populate the pages, so that pre-faulting can map them writable. */
> > > > >
> > > > > Reviewed below, but I wonder how x86 could then read fault these?
> > > >
> > > > KVM_PRE_FAULT_MEMORY is defined as a read fault, but x86 maps the page
> > > > writable when the host page is, and marks it dirty, unless it falls
> > > > back to access tracking (below). Populating the pages makes sure they
> > > > aren't backed by the zero page.
> > >
> > > Before we effectively solidify the behavior, I think we should have an explicit
> > > discussion about the desired behavior of KVM_PRE_FAULT_MEMORY when dirty logging
> > > is enabled.  E.g. the only reason I kept the existing behavior in my auto-prefault
> > > series was because I couldn't think of a good reason to change it.  But we never
> > > made a concious decision in the first place, i.e. we never considered what would
> > > happen if prefaulting collided with dirty logging (as evidenced by this bug).
> > 
> > Yeah, I do worry about implicit assumptions (also commented re: ordering).
> > 
> > I guess what makes sense, given the general approach for prefaulting = injecting
> > a synthetic read fault, is for the expectation to be that it matches the
> > behaviour of an ordinary read fault.
> 
> Unfortunately, what happens in this case is not as obvious as it sounds,
> because a read fault on a memslot backed by guest_memfd maps the GPA with
> read *and* write permission on arm64 (if the memslot is not readonly,
> haven't checked what x86 does).

Ya, this isn't about read vs. write faults, it's about whether or not *any* "fault"
from KVM_PRE_FAULT_MEMORY should be allowed if the target memslot has dirty logging
enabled.

I'm leaning toward "yes", mainly because I suspect that fully preventing installing
writable mappings when dirty logging is enabled across all architectures would be
more difficult that ensuring generic code doesn't explode, and in practice I doubt
any real VMM usage of KVM_PRE_FAULT_MEMORY will care about dirty logging interactions,
i.e. any KVM behavior will be a-ok with userspace.
