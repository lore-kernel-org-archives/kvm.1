Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600296;
	b=AtwIo2i49e8haOizix3SFUZq9tHv4L8jtAzREO4M4EjYKt7ExWpzK9F7n4PEFW+Fr9S4
	 5k4xEqyk3qRih+g1rdhUY2AMN4DnEwM9QovXuZo32dqs9HDtamP0WNp4fjTLsLphX7chZ
	 eTBm9Jirs9WeUEQf9MsxIQnY5xtFEdK9Y3n0Yptk+OAoHDuTNVd6inXqXtWQz28Kv+mzE
	 PkuWVtgDnD3gOZXDgRv3Dy0+OnvX769ia9EKoTCgkDHE+nJcvjyNDGUAkv/GIMOHxtjdB
	 tkp81t7x02GEf/bAC4J5jCASYw7LLUEHkVKkxthmJzv8L+8DrzAd2ueJ+xSSR4+SGHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=ExEdfB9WwLHoUe7nHSiClkfqem+8Ndsrh2CmQFmZ+3c=;
	b=Ibv0/s58DPYX980t6iDugNILLL1DQdirNNSyriSq2gIBqL4SJKWY7FiAhomtiqfAx7CK
	 SJK7AodHUFfcVKzZyASoE49nU2Fyyr4p2OyR+3Jr/8vQP7Qql65atKZOs8B7dNEbHuu9z
	 w5I+WZ6K1CutlHi+4wwUQmR41esdcSffXS8W96oh4qmhjS5kJ5JnhpuaMP2f4M3z0I4lO
	 expJoPRRianM3teD9bIA7kz3q7AWekZhNeBVmdbDo9wB50Km9YQx8XStCa/4RlF725Ql6
	 7k/FLwYMmmvd2a0Q9nIlQAkJIZo3uejcxSCYiouqnNbta/O1iwbua4kdc6zLnqlCpwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ZOTq6OpF;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512B8606A321
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 09:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 512B8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=ZOTq6OpF
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4ac109a8a12so3230733f8f.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 01:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795600295; x=1796205095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ExEdfB9WwLHoUe7nHSiClkfqem+8Ndsrh2CmQFmZ+3c=;
        b=ZOTq6OpFmLPEfwnp9q8dUA0AGMbQltxU+d0PUMHlX0ejPnYg8xRfbNG+MkMuq8ouPF
         5RwWDOgzMMtcvTSE1C/hLlzuPiUQZYX3PnnJM9OCcyC4YCghxnmn2ED1I7REeawXpTCc
         MyodRJH3uu2ySM5gCJ/RnduJiUL0Nhy4hv+PIvQmV/D1LKJfK2K6YOZlhp9JNcVh5a2t
         LEDl9PGb5xEqTHmHMEv9sbGjoXm3iZeDTi5n+DkZ471czuXyZ1YJfsLVhMxtY1DpivDr
         iRWqJ0kdppUTHXR3FCsll2AVQl7nQYqA+aC7/G4RW9Ncsk96ZIwgi+Vay6i6h04XGVfy
         /Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600295; x=1796205095;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ExEdfB9WwLHoUe7nHSiClkfqem+8Ndsrh2CmQFmZ+3c=;
        b=qgF3cJJ+3rSrQxJTbuhZWbLLn7PGADDdZcQvsyNDGTOdAHzOAXXSw8jxA2+Z6lxgAk
         ASAFbk/1LmsQG3e0nuWVVkE/2UVIQ5U3vjWa530wFNsLQlWSeOAZE2CKNBNL12Wk5SZH
         I+WFKJYFld7NS+ww5GnjdZqx/nH7Jky9aag0hR5wVCN+uwqB481RZrWyBRP7uSTagCrH
         JUPcK4lwfHgfamkFxJgyhsQKe8XiSf+/MuBMjxjI9SJxgdF72v5Tk1AcWFD1tgo+2++L
         LuaMrOg7ETmKuigwqXv+Zue9jHz05xe5GvYVoqC7q6NeSm0VA5NAG/SBPnVlPYKaLRH1
         g33g==
X-Forwarded-Encrypted: i=1; AL+hErG3xQHZP/1CZdtSwbDOpwwx3Hwp4cBZiaez1OMyUWRvpsv12KvNkzY8CMO08tXc3EWW/QE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gAAU4M7I4qcVhMZ6IdtX4vDIF7U0COgSCe9EXrj228y8h49Ot
	FNh4jNW3StWh8fhWiR5XGLsqCWXGAEJK2e1Dcv9OyxHqgeFEoJrcnY6GgOL1NSB1zhI=
X-Gm-Gg: AZFdTZfI0CoS3MCjAGaBaUeUwT4/UKjcm3W1pF843O7V5svXGYXD5rL3amBvMuJsxqc
	vnrOMk401fT61aCh5bXqwf4E4gnfvoPopytArubIZUsLf/0683QiFJlsfNVPX9L/haL7MvRncfS
	wHw++wRZsl+NsAOfF2giD0S30WsnGlSL6ACpiHK3t9FbxGDv9JWww4vdRs30HoEhUEHUrKtqS6n
	aaMHy7gx4lI0CLfELB0BVsg5ejHEs5oqqJNDxgLWUzkjc4gE2oL785w5VE7FGb0WnYqFytHG6Ro
	dm2s0WZ79CVXAJcq4yrIssWnmtKOC1ydEOFaGYaU5bd0U4MXDV5e7eTU5ryK3m1fwylIlfh/vJn
	2uaSyhlOns7VpjI1Ym/mbdVvxpIcgRcQ0wCZKssQMqLYfywQwk/RPnxUaqHb8FSSFNHFYKc/3AN
	apifE2Vua+6YtN7NsCh3gdQsbqqaDYHNhqyQt27F9ptaB6IcWLk3pnKhgHgnV2dCNJBAWeOcJ1e
	l419N/znhOOHXmenOxDr1z423nzLt7/CALOHEbMd7wY77FULJzoEgHQ4VeY2m3A84cyodGYm05P
	EMhBx+88q2aoZeZkg7Q=
X-Received: by 2002:a05:6000:4617:b0:4a9:760f:1824 with SMTP id ffacd0b85a97d-4abb19c153bmr33040480f8f.21.1795600294485;
        Wed, 25 Nov 2026 01:51:34 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b8b7888sm32867213f8f.42.2026.11.25.01.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:51:34 -0800 (PST)
Date: Wed, 25 Nov 2026 12:51:30 +0300
From: Dan Carpenter <dan@pereq.eu>
To: Oliver Upton <oupton@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Christoffer Dall <c.dall@virtualopensystems.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Sebastian Ott <sebott@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	James Morse <james.morse@arm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>, Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 5/8] KVM: arm64: nv: Replace a pending SError when
 injecting a new one
Message-ID: <awavokPJT7G8J2fX@stanley.mountain>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-5-224689d8a764@pereq.eu>
 <awaVj0Aa6dMSksxX@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awaVj0Aa6dMSksxX@kernel.org>

On Wed, Nov 25, 2026 at 12:00:15AM -0800, Oliver Upton wrote:
> Hi Dan,
> 
> On Wed, Nov 25, 2026 at 09:56:20AM +0300, Dan Carpenter wrote:
> > The kvm_inject_serror_esr() function injects SErrors as the name
> > implies.  The bug is that it doesn't handle already pending errors
> > correctly in nested virtualization.
> > 
> > In vanilla KVM the kvm_inject_serror_esr() function always sets
> > the SError to pending.  However with nested KVM, it might set it
> > to pending or it might deliver the SError directly.  We can only
> > have one pending error at a time.  Imagine we enter the function
> > with an SError pending already.  In the current code if we decide
> > to pend the new error that's fine, everything works.  However if
> > we decide to deliver it directly then the pend flags should be
> > cleared but they are not.  So we deliver the SError directly and
> > then the SError that was pending on the next exit or entry.
> 
> I could use a bit more color on how we got here. From what I can tell
> this state is only possible if userspace changed the routing / masking
> of the SError outside the context of a KVM_RUN. Otherwise, if the SError
> is deliverable on guest exit we perform the injection prior to exiting
> to userspace.
> 

Yes, but the main reason is that I'm changing the way
kvm_nested_sync_hwstate() works in patch 7.  Now every stored SError
stays in NESTED_SERROR_PENDING across handle_exit() so this situation
will become more common.

I will include that in the commit message when I resend.

regards,
dan carpenter

