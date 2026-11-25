Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617407;
	b=FFD0c/5/ZZkm4AX+1yULPqRQPIw82YLogFc1OWsuuX9lHBtB5wsKhlaDezZDcxqZMK3j
	 MeE0f9K0DyRsn37D6uAnbMAi9WZcBiNLWtMM1+AHaAOOOLuJ5GvBxWD+4PBGsmKxkw6gf
	 rXKS1ORfic51o+Lk9h4WFZ45i0aAeqDXDeBaSyrWG4YYQxLND2OQnXRNkLwgQO+t9qdQe
	 w75UtF5sC96LQlj/VBq2bAbvTa9XonxdOJsWH9wsFPBFuB93FGcPo6dbXWhVadyHhEeNj
	 36akZb1wBgZrVOsuk7OAQVjIlh4598HiNjrPxH7+MQiMX3/W8+0EpCbr/cCvckyR3ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jZ0ODJBUI26+BRK0bblrmNavhVVExfleUfyE4pxTCBs=;
	b=CVyT/4B2uECLPauTdAmAEKEfn38jPlbbafeuiBpxe/E6EsUYN8+409EUWzH7XbGCRU2n
	 nMjVbpTI0SveLrIz/pjGZrvVw4iTo5kkYzZgmd/5DHtqpH9FH2JLYhdYiw9/hq3ePPsap
	 e2nLa6FqSPzitO5RoqdyYnuZETLLtfYk0UU4PIf/AXV4s8ppfrZ/JiAAsLY+QGXNXwAeL
	 R71GKDw0vmqJtN24Mn/BjVWFYZmWVa6ktI2ggt+pIaSebQom5tT3D4NDDGPbdpkX0o7yS
	 IMcnCAjzLGHqKBiOZQO/toLf2x8IVyjPbGRugE0zbF7ZEFjmGX5prXDvhHNQOb4RJ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TBwymOjU;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83D606A323
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 14:36:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C83D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=TBwymOjU
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-55d2dcbb905so33243321cf.3
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 06:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795617405; x=1796222205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jZ0ODJBUI26+BRK0bblrmNavhVVExfleUfyE4pxTCBs=;
        b=TBwymOjUH2EB8jnE/jzDjPScQd3It3v82RC2NRxhvs2i2+7K4UaSp8Xw3uCiWjtTGe
         kkImzk/0l3RKS35F/0uh5EVeq4b2dcQVw4KArqvJ33BGgJW4vi6F825+zw0MUPCOkvl/
         W2Jd34E2x0jQePn+vWk20Qw0hhq2Q8xLeMfwO6G3lvMay03YVrI7p1BpTJOlCxRHNv1U
         /n4dKrk+8omNEbO6MBdm8W41iKx+OVaH/j/OPmrGELVxP4Q7deOURL/4aXHHt1Rk/6SQ
         uc0ElLV3QXhdtmR5JdhJ/QjlyMhhFPc6RVwFDLFZzkYr+AQgyTNkdauIByHOgi9XlWQk
         CYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795617405; x=1796222205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZ0ODJBUI26+BRK0bblrmNavhVVExfleUfyE4pxTCBs=;
        b=olnYDiZyUB8tfiju+c/07gDwsA8V843GPnmZXWyMspzrMWo/biCaNkxNEsx/p0U/MA
         u/WxfnXInGb0z0kP6bkoHmDH8DCf7QUdtYpE03Jr1Ya1/7TcslCuHxxhO6OUyFqjCwID
         zZcVLSS0c4dtuguDE9IcuD3wqmdC/8lCT3GmK3Xszk9bmO5r6Dk4AhvDoatGTynbgD45
         gQvx1qqpF517u35IWkvA9QxM2Ta0Sd+f1YE8sN1mFTSey/YY6lJ6nMpGpo+YPwUPpCYs
         Gmz02R1C3EWPMFkhDRRv3iaNX71zerPkunu3YNxv2dSxKWBJEaaAJ30ba1w1x5XHgblQ
         slbw==
X-Forwarded-Encrypted: i=1; AL+hErFoSQDFN2b330uo9oG94PIAS0Ylr3bcUrHcDiTpWGhisCLRzngFIstdQVO87L2upL3UpZA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+epAQ0I9AhTo44+Ez/xPjBOwd0ZorSRd+mNH4SAtgCsD3HScOR
	W504VcVKTqTYL6tzu/0dmgjs6dhOG0E52TODOXtQYVHUnA9j7qEKWTGSeHPol27RCIU=
X-Gm-Gg: AZFdTZf1NVfY3ts+0Yr6rz9BpMRXfBC6x7a/dt31OsEPiRfLkxPHtDET+KlvRmeWhC3
	4uddRahFZWtI0zvsyynJF2C+XdBzMlY4SPrQN2X+ZWXLhAfBTZbL03Wb0YWcjsA2+HIdz9ha9l8
	3cJkaDI5iyuBxdFfhQp8f3a9VexVlRRUQJgnmrtOFBVaLfJDDOSo2/gClXEnB8KbVhZSBmv3urB
	6O9PNuZm3ExhPxU4IyACh8UBY+Ey3kPKAw5ftzWNY2pfjbna9deqkOow0vuFzQY5GoMCYcC9oQH
	7wHb8VvYw+9bnexyb95NrHdu4LIX6faL8j8G1UYV55Gtype2lXmWRo0ZFg2wUQzPrpZJUe6Dxel
	dq453qZ0CdP83/vHDi6o37f+HV43mbjg/jFKNKnXzAHfwEJ62X9/+Klu9CYWr2PigMAfW55PkWK
	In6lWeZUrRlDV19a1cqtwdGET5kTsLNNxEzKKstbVT2f/iKcKQ9LtYfFhoRa4dp8bwikzCIPRiA
	X8hHzr49bZxFvOZMJjj2+s5iQaUTkRqqWz3OjFzL2cEZspkuJK0r9HlYwKqiEsLgr1koUMmos35
	S8utyw==
X-Received: by 2002:ac8:5e53:0:b0:536:699d:9a22 with SMTP id d75a77b69052e-55d76aa8754mr328840131cf.57.1795617405368;
        Wed, 25 Nov 2026 06:36:45 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78880604sm157945401cf.24.2026.11.25.06.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:36:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWE72-00000001la3-15Li;
	Wed, 25 Nov 2026 10:36:44 -0400
Date: Wed, 25 Nov 2026 10:36:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lukas Wunner <lukas@wunner.de>, Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 05/10] PCI/TSM: Add association locking helpers for
 evidence acceptance
Message-ID: <20261125143644.GF246011@ziepe.ca>
References: <20261123083337.2731019-1-aneesh.kumar@kernel.org>
 <20261123083337.2731019-6-aneesh.kumar@kernel.org>
 <20261123153507.GH179082@ziepe.ca>
 <yq5ald6h9r1g.fsf@kernel.org>
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
In-Reply-To: <yq5ald6h9r1g.fsf@kernel.org>

On Wed, Nov 25, 2026 at 03:22:27PM +0530, Aneesh Kumar K.V wrote:

> > That cookie should be held in the attestation driver and when we get
> > to acceptance it should be presented to confirm that nothing has been
> > tampered with.
> 
> We already do something like this on lock, we track the cookie as part
> of CCA and use that during accept. Sure if every architecture supports
> this at firmware level we can abstract that to attestation layer. Yes
> and this protect from hostile host.

Every arch has some solution, but the critical part is the cookie must
be tied to and exposed into userspace.

start returns some cookie ID, and accept only works if that cookie is
still the current session.

Since we have a uAPI that allows multiple userspace threads to open
attestation this cookie prevents trouble if something else open/closes
the session from userspace.

Doing it transparently in the kernel isn't protective enough, IMHO.

> But this patch is about keeping pdev->tsm stable in the guest. We need a
> mechanism to associate a TSM with a pci_dev. Currently, the host uses
> sysfs 'connect', while the guest uses sysfs 'lock'. It is not clear that
> we were proposing to remove that mechanism.

Everything uses connect.

Once connected the attestation FD is created and its internal locking
and disassociation scheme will prevent any issues with TSM hot remove.
Basically when TSM is hot removed it unregisters attestation FD and it
is attestation subsystem's problem to lock that, not TSM.

Once the viommu is created then the ref mechanism you build prevents
TSM host remove while the viommu object exists.

Together these mechanisms should encompass the entire uAPI we see
right now, so we shouldn't have or need yet another layer of locking.

It is why these sysfs's are looking more and more troubled since they
are existing outside the natural object and locking model that is
emerging here.

> Are you suggesting that the TSM association remain under sysfs control,
> while IDE teardown and TDISP unlock become CTLV operations, and that
> sysfs disconnect or unlock be prevented until the above CTLV operations
> have completed?

That is roughly what I'm describing above, it should fall out
naturally from building attestation subsytems lifecycle model
correctly.

Jason
