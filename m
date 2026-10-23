Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792764742;
	b=BWV67lSMxT4Y1TrCbCbEj3GHSLVW+60OvqNvs4Q1AbE9R0MCBxXIaAzGiuUZT4BXgCAB
	 vQIbLP42BMxmTMcaCHJ3e5cV0a7R99GYmzLfvBm0hpl8Ec4OaWrYvNM14EnfK3XMSehoi
	 MNiDUIOUKdnb5Bu+fS60ftV5d3VSloYTiX9W159lHvqyuP93azkRQN51TPX/T0/kKeW8y
	 lsFm66yzb29d5DKGT1YR3DL/rL6SrNMn1F75Tn/Oc+T6HjkmMH4r8WZlooKUODa7Vf0cF
	 az8aTFgJDzc6SSMJjR6SwbpNsXSD+d6AprrC1q8k2PdYASC7ST21seOqVewwEvD6UHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792764742;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=oJA2TtslEJ+KdyUtrabQXqX04jIwVEOHlYhkzmtq54M=;
	b=GF06dVK43skT8rw/P0dmHR2FWnp92uhU28P2s9N6eR3W9lK+EdhpPsHUEmuZFPrX3sy6
	 Mu7sRKsKr1iDkZEd0n8vE2+Ey7IGbPmfBgkaGLkONpMhmWv1q8jdQ4pqth5WflazidyGP
	 s7g2UUIh4ldsSKA3VpLsS1Ux2Oro/3owU1BqGpeVjZXwQYAq3D0tlNQW1u3rIfWRoGzXP
	 d91cqOP57QybpTO2kDj61kOBrRgPg+6+Z6HwrdDnjM5S+fNPUgxMHekCKcrEEVYhPzzed
	 cD0a4FXgbVHp1AaCmvpb+Sbo8hX4aHjcHpLwBCD2D47rATmA57+xfCJ1I+6cTlTy4PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XJJ6FvlZ;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14007606A31D
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 14:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14007606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=XJJ6FvlZ
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f1cf92c9eso107207885a.0
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 07:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792764741; x=1793369541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oJA2TtslEJ+KdyUtrabQXqX04jIwVEOHlYhkzmtq54M=;
        b=XJJ6FvlZqxo85XzvMv3kvaZAtfiHwhOx8sBMHh97IiPVXdiYFm54L4CeUcxoOzzNvt
         gW+kVZ5P6SiTD6i3qbbWqaK7N3DN+3iChx5c+N5ynHcYMSMfW3HvhvT9ZIl7yY4FD0Ix
         OcxHouZP40lKVsKApA5S3figCXfZVQ5fGlQRJfyQnR1vO9veiYbbk+xedFHTt6HtsYeG
         7tA0YHNoXFR4ZshrmdNr6q3G2SLk9NVJZ09vuF5/ocFe5M8xR/jCGR3A7lq5V/cGI/X3
         1M54/n3yKnC/wLHUP/du9/EMWrxSUFPTjcDMvQYzNxQaB0/Cg4NMgodVwBAx3xXhzQjm
         XA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792764741; x=1793369541;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJA2TtslEJ+KdyUtrabQXqX04jIwVEOHlYhkzmtq54M=;
        b=Rw+ZdSeSgsfTLTG8FrTzSiBooKbEtKHduwa/0vzHngE6b+jB/tJknKMUCa7p6NCZXU
         z66xvwlf2bnSAuSTP4H8yXL3SA6HPN7usd1rgXEzE8XoXNOz5oKDZBweVxGMHmoU5QF7
         /sFGMq8iiUux27eyRvggxa7FBnPTPNA/+C4ThYGgYrzCw3AocKAk3RfTG29uxpS+JQrr
         aD1XK63l8datiNhma7DZABdonQ6nAnVxqIkOCOyq5NN5Gnkawu0/XcHLjM3iUkF7uIi/
         2mtCurdjxVCdap3w6q0R5HNKnMPCSQ5vAOYyw6h97hOroCVkka+9R5L5aK1bMh03Rh84
         lB7w==
X-Forwarded-Encrypted: i=1; AKwUvBzGlc4Sc4iS5lh9z0WmcqNYiHQ2pBjEpMIOoeFk2NMKzV+Ahkx3aW0AHNufp4dJ4OZDQp0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIOFctN492QIGOuoAWrFZtzOTM5hg7fxf7LiAy32sZUOcNc6ZMS
	XWYl0bdvEHIqLHAMKLHDC7EZ893x19yA8xab4pvqnLVMYQs5wGhJ5oGRKhzGGtMpoSA=
X-Gm-Gg: AYBFou2uGs3zEu5VpZf89If+8yTNYgybh/pLh5vWzg07EU1tdYOFQTkoE9AUU53D3x7
	wwgPCAP3hXPQSl8gKgs5ZG9dSKc91gLhOEGfuu5ZdNAHeB0lq3oXcR09ZYEyGJHQpZls6zaUe+W
	OSccCpxviXyg4+A5r3gk3FQel+/PWoR65SPrnw8xnDASwOez2Nm4nByzC4bBOVYU1F2gEzKQoIK
	l1CeCIcZ7PcvK/dUIPq+iZAFVPcLYd5kyI1PyjV6GfalcMsC57wcDeLsQujivCCrfpGbY0ev4B/
	rNhiRLn3nM+Sn4MtYUThDPmGIP1ieCcflI2aXn1mzwsy0IHYeQgBeUM034/zouzKuj5EGPvcz0r
	bC8UXKbXPGLhZIUmgdup1nf9bEi/gcpMl6BlzcXYXwHaglUDOXZBB1V0v5pvyNEN8XUhUaZbM87
	wX4Ym7AK0a3GGmr8LsaEmIieNzDm76GT3uf3yqsXOSIv8/CBc23OmMHElaaOozMIX6IaDkxcEUm
	EUAwMjTfL/wN4qZrR7/+LY7VTBZxpUDzBH2G7LiMEVsj86n9R4MiMPSWTFV8OiPmIBSsUqz+Q7F
	Ff9ykPwTN4RWOQlkP2ljWQup50dqdij7KiHWcQ==
X-Received: by 2002:a05:620a:280d:b0:93f:53d1:54c7 with SMTP id af79cd13be357-93f6f8249ddmr448815485a.70.1792764740975;
        Fri, 23 Oct 2026 07:12:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94047b32ed6sm25764985a.34.2026.10.23.07.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 07:12:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKG0I-0000000Gigv-2y8C;
	Fri, 23 Oct 2026 11:12:18 -0300
Date: Fri, 23 Oct 2026 11:12:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"pgonda@google.com" <pgonda@google.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"drdeeglaze@gmail.com" <drdeeglaze@gmail.com>,
	"James.Bottomley@HansenPartnership.com" <James.Bottomley@hansenpartnership.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	"alistair.francis@wdc.com" <alistair.francis@wdc.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"ankita@nvidia.com" <ankita@nvidia.com>,
	"jpiotrowski@nvidia.com" <jpiotrowski@nvidia.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"Quigley, David" <david.quigley@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"ksinyuk@kernel.org" <ksinyuk@kernel.org>,
	"Fang, Peter" <peter.fang@intel.com>,
	"sameo@meta.com" <sameo@meta.com>, "aik@amd.com" <aik@amd.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"qinkun@google.com" <qinkun@google.com>
Subject: Re: [PATCH RFC 20/20] attestation: Add the TDX family implementation
Message-ID: <20261023141218.GD3977851@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-21-jiri@resnulli.us>
 <ed52bb6d48c87ab8023bf2165cadffa259e21725.camel@intel.com>
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
In-Reply-To: <ed52bb6d48c87ab8023bf2165cadffa259e21725.camel@intel.com>

On Thu, Oct 22, 2026 at 10:07:28PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2026-10-15 at 16:50 +0200, Jiri Pirko wrote:
> > Connect the attestation family to the native TDX service. Expose
> > TDREPORT, Quote, MRTD and RTMR operations while preserving the existing
> > native interfaces.
> 
> Along the lines of some of the other commenters I'm not clear on the benefits of
> the unified TD/VM attestation part of this.
> 
> Especially when you talk about a TD report, it is pretty specific to TDX. So
> calling user code is going to need to know about TDX anyway. In fact the report
> won't have all the details of the TD either. Going forward it's main function is
> to serve as a nonce transport blob and it only has TD details because of legacy
> constraints about SGX based attestation. So just a quirky TDX specific part of
> the flow on the way to get a quote.

I think in the way this stuff ended up being used the userspace isn't
actually aware. It just wants the VM's ROT to sign a challenge and
forward the resulting blobs to a remote verifier. The verifier needs
to be aware of the format, but the collection agent should not need
special knowledge.

ie from the perspective of systemd-report it doesn't make alot of
sense to have it know every single special configfs path and protocol
for each CC vendor just to get a 'sign my challenge' operation.

That's the general north star here. We'd like all the vendors to be
able to do collection without having to change systemd for every new
innovation. Again I'm looking at 5-10 ROTs in our platforms, it is not
desirable to go and teach systemd about each of them.

So broadly, this requires a challenge to go in, a signed blob to come
out, possibly some suppelmentary blob[s] (like certificates), and then
labels for what is inside each.

Userspace would collect all the blobs and the labels then ship them to
the verifier which has to understand how the data described by the
label is organized.

I don't know what "nonce transport blob" means in the future, nonce
without signature sounds like a strange thing.

> One idea... Not sure on it. We are currently working on support for DICE based
> attestation for TDX. This is an industry standard and AFAIU other vendors will
> (want to?) support it too. Perhaps if we could have a single way to ask for for
> DICE based quote, it could make a cross vendor interface more useful? Callers
> could just call and get some standard format they can understand. It might take
> some work on the TDX side to ensure the DICE format quote.

Yes other people have asked about DICE interfaces for other ROT
devices. AFAICT DICE is more about having a standard data format, and
you are right about everything..

Like SPDM I imagine a set of interfaces defined by the DICE specs, but
we'd probably still want to have the basic 'sign a nonce' interface
for opaque transport.

So from a TDX perspective, what would you want to have as labeled
blobs for this kind of operation, now and later and maybe someday with
DICE?

Jason
