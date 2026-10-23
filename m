Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792835;
	b=gJRkQSlD9WEcITqDR5R+lVvxrwCeVgjaZd1CWSoFv4FbIUO8HVJgbMsM9WJvL3fjNyuM
	 0cSFvvaLW9QUS6nt8GJJ7rCG50y7+CV0fqgJtgdQY6ZsghF7csA/TpLgjoziEoUOEbRt+
	 q/VV+PIu730zNUP7eGTDNsOcrdmTmJz/B2LTP2NPaTD6F/4yAngdOU7cSVa454ZpZNYLD
	 0VPRdgdG8JgPzrxy8N9oUqUzxvZVZA0yoKWUaxKVWqKE3BfRIgWQH7WvMHknfXJdigWMl
	 KdyFE0P9TP/AqmvAweEH5uozrTKVkSIJsYhOUHDP5i7H8wW9RpKXsxlIxXXy9M7SoQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cEebfXd9IhliqLZGZPa/idiUUw956gBCSaHIyOjWMY4=;
	b=hiZnkWRQcvDEWav5Pha4akK/udAwQlM/zwOriqUdKic+Gc8XWCq3WVgl1eh/5evzC+aM
	 oOIkwWgLbuq2rru4Zj64jdoiNI6U5awVNx9pyAo17G0c/CZvxahV+KHUdnB4cTNsxJiGt
	 igAF2G4PE3f+oGAEal48TVckg72LemKWPvSsCXdA3AsKtF6BVCd5xld55rFRVklcAc4YF
	 5xcUsoGrp4KnYbKU9OL3xN739rVzVmBiAYN+BRStR5tZS9ERyvP4AMOjk7bRVQyHrFJE1
	 fMr42TZTgEqddoebyoRK5PSIIDvVjf5FzPapWv5VNheHP9u82Ir6yQyoAyW8SuamuMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fGHN7UBU;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2EA9606A322
	for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 22:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2EA9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fGHN7UBU
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-917997ab0d9so15515976d6.3
        for <kvm@vger.kernel.org>; Fri, 23 Oct 2026 15:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1792792834; x=1793397634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cEebfXd9IhliqLZGZPa/idiUUw956gBCSaHIyOjWMY4=;
        b=fGHN7UBU5V0QhnvTs+xUkPJhS8vNK+O+TUoTXa9mcV/F+gWHO0P58xt31cyugMGBsc
         8NhY+YwsZ8QIq8avKnZe7sVhN0DpljcQ8TgCzEne9cY89MU/R9xjYovBvRTpvA1dKyg+
         thqK20/E9HV0APohdnApvO0SRJ8oI8xWJQ/AwJ1B3thQcOYW+Y5uN++RSuGZzq14FFk2
         roSizJ7JamfpKmfhrLIOXC/zZiN5APzwQADAfbR2R0iFWLdz6Dvbp92CTTCWqSM+rKeS
         kt+8XYQVLQPLSgQFtgWtOz3B0Z5KxVkq7mt9JIg3KA3yf2iw1VzMKbNTr2dKm6t77K3U
         5nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792792834; x=1793397634;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEebfXd9IhliqLZGZPa/idiUUw956gBCSaHIyOjWMY4=;
        b=mbPuUXVhzuHE2e8BREHzyinB1W9P7DyqJK15pOyfthyucOCfqVjoAURLft0r8stVto
         8zuH83YvgsBa1VHURCnSdyvSZL5x/bBSqQJfgnETpauRHNXdaXugMhOisrkn9+g9m6nQ
         KlT5Asmc9kjxHAAeIpVskVHEuuwEtH1zYgAEefRPX48weyl+JTQw+fMFIv9i4M58uXw7
         jT+rsiO1y9B9LF0Jr+rJCrxNeyiQao+G7zBgr7d3GCWlZboJi3IBxtXeCgKK4iJ1NJ2a
         mBzX1VcQi1Zq3WWUsCJ4mSaD6EgpsjaGWu/gH4uDITaN5TskvsQv1ZQPgfTj0PiSvIYS
         QA3g==
X-Gm-Message-State: AFq9FYKMa9VVPpwzzNxqBxg0GuQMTS0zTSJryL5W1F6ozMPGIh8eSqke
	vz8IlEOkLqc26llBey+rkaimy1RhDt2N05KGFpL28VUPgt+qOKCUt0s6npH3FhlqRI4=
X-Gm-Gg: AYBFou0n/ahsdyPSPwy7odeI7DysVwKr4GX+/wtvl87r6OucaUjUcN7E18gCaFjgIIP
	3yvPZ4mSk3ot85Sx77nDZBcq0Dj4z5yafdZHKyPFPtwEpLxdAeHeNwFw8937HlO3JGLNmvxD6jp
	xX7tvEEGoSkztwLO9h6vhMUok7yqY8K41KMnjNI9/+NrZxiQJ5LSsOEasze0jnLOhwSVDUKD9G1
	AIiO8p5N2Lqp0RlSz9xV3NE7F7khmO0kl+vivrTDooU8HD20IkYeCxGCEfXfjGfXT5RrZl8ONxS
	u7dJXRoJpPL2lo/XiY/MiEItJPRtOqviqUFVSUOGY5lZnDGLMs5LUDalO7szbN1IkrYmoXNfiIY
	ZYnp9I+OT8FTHbokpAKOkawYBnwFuqXy8ZYvz3uglkzSjoPoRmS0Cj8lsj58G/xfYD7HtzPOfeN
	0BtW6o9gA4KmWE5jdHnRnlTbrIeTA/vblzNmq53xD6Vqne0+SLZQ+weitdVDGvIjS8vWgU5+wCF
	bzRDrMsOtKrTocWClqpGWI4QjYrRtxaQ1oH/WTIb3os4XK084XmTJXXGCOZogmEAWCkMWtYyA2n
	cYppMzJT02UGvpERsQVYk369tIMtqhtlAMdFoS9jG1kgYLmj2KK6hXh6Lik0
X-Received: by 2002:a05:620a:27d6:b0:93f:57a3:71ab with SMTP id af79cd13be357-940ef93d248mr49492685a.32.1792792832337;
        Fri, 23 Oct 2026 15:00:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0a78c06sm17716585a.35.2026.10.23.15.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:00:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xKNJO-0000000H7Rz-2dan;
	Fri, 23 Oct 2026 19:00:30 -0300
Date: Fri, 23 Oct 2026 19:00:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"Fang, Peter" <peter.fang@intel.com>,
	"drdeeglaze@gmail.com" <drdeeglaze@gmail.com>,
	"James.Bottomley@hansenpartnership.com" <James.Bottomley@hansenpartnership.com>,
	"sameo@meta.com" <sameo@meta.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"alistair.francis@wdc.com" <alistair.francis@wdc.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"ankita@nvidia.com" <ankita@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"kas@kernel.org" <kas@kernel.org>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	"Quigley, David" <david.quigley@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"jpiotrowski@nvidia.com" <jpiotrowski@nvidia.com>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"lukas@wunner.de" <lukas@wunner.de>, "aik@amd.com" <aik@amd.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"ksinyuk@kernel.org" <ksinyuk@kernel.org>,
	"qinkun@google.com" <qinkun@google.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH RFC 20/20] attestation: Add the TDX family implementation
Message-ID: <20261023220030.GM3977851@ziepe.ca>
References: <20261015145053.3664509-1-jiri@resnulli.us>
 <20261015145053.3664509-21-jiri@resnulli.us>
 <ed52bb6d48c87ab8023bf2165cadffa259e21725.camel@intel.com>
 <20261023141218.GD3977851@ziepe.ca>
 <343e4a12f2fdbb4e9a19c4afe49cf2b8908d6739.camel@intel.com>
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
In-Reply-To: <343e4a12f2fdbb4e9a19c4afe49cf2b8908d6739.camel@intel.com>

On Fri, Oct 23, 2026 at 07:40:58PM +0000, Edgecombe, Rick P wrote:
> On Fri, 2026-10-23 at 11:12 -0300, Jason Gunthorpe wrote:
> > I think in the way this stuff ended up being used the userspace isn't
> > actually aware. It just wants the VM's ROT to sign a challenge and
> > forward the resulting blobs to a remote verifier. The verifier needs
> > to be aware of the format, but the collection agent should not need
> > special knowledge.
> 
> So the verifier is a standardized endpoint of some kind...? That makes sense
> then. But I think we don't need the report in here then. Just the quote. More
> below...

There is a direction that the collection agent would be standardized,
systemd-report already exists now, and so the verifier would accept
the data blob defined by systemd-report and process it. I think how
the systemd-report output is convayed to the verifier is somewhat more
open.

> > ie from the perspective of systemd-report it doesn't make alot of
> > sense to have it know every single special configfs path and protocol
> > for each CC vendor just to get a 'sign my challenge' operation.
> > 
> > That's the general north star here. We'd like all the vendors to be
> > able to do collection without having to change systemd for every new
> > innovation. Again I'm looking at 5-10 ROTs in our platforms, it is not
> > desirable to go and teach systemd about each of them.
> > 
> > So broadly, this requires a challenge to go in, a signed blob to come
> > out, possibly some suppelmentary blob[s] (like certificates), and then
> > labels for what is inside each.
> > 
> > Userspace would collect all the blobs and the labels then ship them to
> > the verifier which has to understand how the data described by the
> > label is organized.
> > 
> > I don't know what "nonce transport blob" means in the future, nonce
> > without signature sounds like a strange thing.
> 
> Yea, it's strange.
> 
> The initial TDX attestation navigated some platform limitations. It involved an
> SGX enclave on the host. The enclave was the thing that did the signing, but it
> did not have any of the TD details. Only the TDX module did.
> 
> So the process to get a quote starts with getting a nonce from the remote
> attester. Then the TDX module took the nonce and formed it into a MACed "report"
> that included all the TD details it knows about. Then this report is shuffled
> out to host userspace, which gives it to the enclave. The enclave just checks it
> and does the signing. Then the resulting quote makes its way back to the guest.
> 
> In the new attestation, the signing happens through the TDX module instead of in
> an SGX enclave. Since the module already has the TD details, it can just add
> them itself to the quote. So all it needs is the nonce. For legacy reasons the
> original TD report is being used for the nonce delivery to host userspace. New
> TD details are not going to be in the report.

Sounds like stuff the kernel should be hiding right? Userspace gives a
nonce and gets back a report, it doesn't care about these details?

If there is a v1 and v2 report because of this then fine, they can be
labeled that way.

> So I'm still not following why we would provide the TD report through the
> standardized interface. Maybe we don't want it?

My biggest motivator is to get the measurement register stuff brought
together so we can multiplex it intside the kernel. In that world I
think it is pretty important that the signature covering the
measurements be clearly affiliated with the measurement registers
themselves so there is some hope of userspace figuring it all out.

attestation subsystem will describe it as one coherent whole, you get
a single TDX /dev/XX that can do extend and generate a signed quote of
those registers together. With the same interface as every other ROT.

IMHO it makes no sense to pull in measurement register and leave
behind the quote in configfs.

I grant you there will not be a huge amount of value in moving the
quote over besides this consistency and ease of use for userspace.

Though I am planning/hoping to have a sane admin tool here as we agree
to things, so admin can do like:

$ attest report
   TDX Report:
     Xyz 
     Abc
   TPM Report:
     124
     435

> > So from a TDX perspective, what would you want to have as labeled
> > blobs for this kind of operation, now and later and maybe someday with
> > DICE?
> 
> On the TDX side we would have to work through how to ask for a
> specific type of quote. In the initial set we have planned, the host
> will decide.

That's fine. Broadly the "default" report format should be set by the
VM's instance type, eg defined by the CSP. It should not change
launch to launch of the same VM.

If you also want to have a way to query specific types, like AMD's
guid thing, then that's fine too. But I think integrating into systemd
report might be a bit tricky so I'm not sure it is a great idea.

In all cases the format of the report is labled, passed to userspace
and given to the verifier. I see Intel already defined DICE format as
'larger than 8k'. We'd probably want to give that a dedicated label in
CTLV land.

Thus, if you boot instance type V1 you always get the same
systemd-report format and a stable ABI there for your verifier. When
you upgrade to instance type V2, the report format ABI can change and
you have to have a V2 aware verifier to process it. Since everything
is nicely labeled the error reporting should be better 'verifier
failed because Intel DICE not support' is way better than 'signature
failure'.

One of the things I'm quite adament about on the data labeling is that
if something sees Blob type A then it should at least be able to
verify the signature. Further format variation should be self
describing data within the signed payload. If it is so different that
you can't verify the signature then you have to give it a different
label too.

> Do we think there could ever be a usage for the coco guest to
> process the quote itself? If the only use is shuffling a blob to the
> verifier then maybe we don't need this either.

Probably not, but if you wanted to, then same process applies the
verifier, you get the label and the blobs and you do the math.

None of thes concepts are really changing from configfs-tsm-report, it
is just wrapped into CTLV instead of the creative use of configfs with
hopefully a bit more robustness on the data labeling.

Jason
