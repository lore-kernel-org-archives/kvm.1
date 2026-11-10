Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335252;
	b=hODHP1vDhJ2bZ37a1f0RtqoKZuC1/sMC1vfmCj91BYSSKeBD2zD/L4V4eK3hzXyFe7W+
	 RETb2PaiDgkgv9MCRedO2L4jV7qOj6m4HHckMC19mo+BfRjc45jFFMdNBXirQ+47xgNVC
	 yf0JHjL94Ga6XfRdrINHtxTLNouEs9Uqe0KX8rDnxmrWvdMUa+/AfCN3sTqFsE2xNl4Hr
	 G5QiII9tUC4xAIhdN+xCqeF4CR5DotxyVAFdJy7QGn0EYIhJUMFnXTsKagF7tMILvrzsB
	 DbFcpU+2pM6wnPmBHXvzlPxr0YB6YcpOPRKgXH5okyz5aO1hRuixfksnSp/0PqFDZiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335252;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YXIy2qRY3m4JoNqfvZNIVm9KUne3fxI0qe7Yqqt3EGs=;
	b=GM9cgFrgCJeWZqZskFrTPzs6mJKUUCWVPlkpiPlrxuDAfN669s9hC7idwC/sAw/iWydw
	 xBQYU7K1cwQyPEy5yXHdemPY894ssh1eM01SRXYpKDnXmc4vPVCJTq/dejpos1niKgiPO
	 GekSl3LC3md8dU/l3Sq+SW90guFUPDE4tmEeqeUsoLVZw7R6fo3EHAHVCbZ0BDEKiyC/G
	 gp+RapvELeSQyhKrGk0fUjKiFbZ0Z5HRGfpWYkxeTOKPdaTypTlOHkRgLUSxwCWBx3fR8
	 IIG8dAeoyiXDF6/Fri90n0v7Q1VJ4vtO0lPTy/r+gMt8PzWSuTAMjd/OtoGPrgHxOkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=J7TMm8T3;
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35457606A327
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 18:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35457606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=J7TMm8T3
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5364d86f7f0so25845101cf.1
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 10:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794335250; x=1794940050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YXIy2qRY3m4JoNqfvZNIVm9KUne3fxI0qe7Yqqt3EGs=;
        b=J7TMm8T34Tu4l5OHcANKwx0/ZOzfapRBnEg4cXPKDFAtzJrkdsQLmXQH1PNBaI+LZH
         HQxhcvnWaPMv4Mdu99jEJKX1gAfpkqK9bmVZNQr4gKf5Et/58JlVsH9oOxDsx7bqpFQu
         ZXW3WV+2lrudMoNdhU32xg9MgdSNO1NqIogSK+UVa/6AQgjRkJQkqGErKB9UAMu1XqgJ
         3fZPTlqW+B98MNIeDrnpleLnnPacRQ56XVQM2pIc4xb54sJcW/ZDtQ/K4p7vR1GL4gM3
         rK7V1sGMQaqI7HfANYUEMk0S5fY/S6x9xF1CTrUP9NqUwRARSKYQRXehKzOgiVLCp6ft
         i0vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335250; x=1794940050;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YXIy2qRY3m4JoNqfvZNIVm9KUne3fxI0qe7Yqqt3EGs=;
        b=UwNA5zq/3wLaafXnw/Uaua3Z+Gnt0c0YO1/cgJTTjuveylCv7V2rGPmq5M1U4GZjhT
         G1t/ffgKtHprb/R2HdMTd86vB+U9ufStenKHKSCaxSCLLMmCVBO8Sv3JPPUIYKAI77hf
         KN1RGsXajWeDjO8UZjP+5SK7DSg+zucGj2ISgajyWRZxORyyXSxIv9cuQxqR3LB1aP0g
         djC0e1PYciynshkAhZrClWEK2Y+4vQ/oUwcmhVsqOy2GzAqpnB5XMkucLHMpdckywoWT
         1n3BqPK8r41/PFHOcbpSk6M1CBC2xOx2Vvfw9QlFFMVs4KuVk15QYSzxvF1oRzxzMKP3
         gj5g==
X-Forwarded-Encrypted: i=1; AL+hErGQko21W64vVDk0YZ/dF8uTeki4C7gv6ct43PyMWSncYyO7Ho4NVTgr9O0wLi5YAJRk6Uc=@vger.kernel.org
X-Gm-Message-State: APuU4Z84p2EPQkfngIcCGU7Uwzl/DPPc2c+vqR6U9pbIZi4MKbC/0qdj
	qE/cRifjbjJjtJg36hxoijKutELAqNj4gReBFd5gnKQT/9b2kt5m+ri9ZFxUAY85xuE=
X-Gm-Gg: AYBFou3wJdUPlRpCxu4Lfe/yEbWp8wiOq9c13672vXBLrfl1XWa2sS/XlcfqMRuXSUm
	XiuricYlywA6vfSaONUoNsSL3dxxoJrcoxxMYxHS88dtDP9TU1UKkRglPpWZVaI+GFevXVZXBB2
	WQowNDiTor+Mt/aHP1ALNJWZNQ3T5cFYGR/+wSjqquWVz707pHE5O9DT04HGBkMw9qbX8rzcbOM
	ZATTPicq/anDUtVddW/eWSpdPt6bTcePwUNnvsNLoC2NA7fBcXiZT+JwEb+pzEgA1hHAMx7mLZo
	8Pp9adRdVYqbgk12wqH7pT84VHKRJACO2iYlUz2GitxlrqQRHUdkrj3KJZcrwavfDClA27Rpcol
	LsvLCGdyAflJCiH4lks7YnCsoKbeCLR0Y3kzkNKgpOuAtIBA1TkrkZskTRWC1pOzDoW3hHs2hSL
	VjtFlY/orX5ktdTQipkz3802O2EprbJRlwO51DM5pQEi5oKpfg0hBZtB193mr3m7I6yeZWbqehR
	g674r7jeVLjSAN0zZqxbBe2iPqQKbeVom7vfub8z6to5FuN9XwK0zwu7b8XxWnYe5pw4OpRBZCQ
	XgU8fMFGG9E+2SR3b9QOdLqG2NbvQ1tZMAEkrUeQ6YU6n5HlCymx+gNu6b+uvFz9y/n8Ww+fbxS
	7eI0W0lmPpB8=
X-Received: by 2002:a05:622a:313:b0:51c:1590:8e13 with SMTP id d75a77b69052e-555257c5f22mr54402921cf.4.1794335250028;
        Tue, 10 Nov 2026 10:27:30 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-555093d9c3fsm30362981cf.3.2026.11.10.10.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 10:27:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQqZ5-00000006j4S-49JU;
	Tue, 10 Nov 2026 14:27:27 -0400
Date: Tue, 10 Nov 2026 14:27:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peter Fang <peter.fang@intel.com>
Cc: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"drdeeglaze@gmail.com" <drdeeglaze@gmail.com>,
	"James.Bottomley@hansenpartnership.com" <James.Bottomley@hansenpartnership.com>,
	"aik@amd.com" <aik@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	"alistair.francis@wdc.com" <alistair.francis@wdc.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"kas@kernel.org" <kas@kernel.org>,
	"ankita@nvidia.com" <ankita@nvidia.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Jiang, Dave" <dave.jiang@intel.com>,
	"Quigley, David" <david.quigley@intel.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"jpiotrowski@nvidia.com" <jpiotrowski@nvidia.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"lukas@wunner.de" <lukas@wunner.de>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"ksinyuk@kernel.org" <ksinyuk@kernel.org>,
	"sameo@meta.com" <sameo@meta.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"qinkun@google.com" <qinkun@google.com>,
	"pgonda@google.com" <pgonda@google.com>
Subject: Re: [PATCH RFC 20/20] attestation: Add the TDX family implementation
Message-ID: <20261110182727.GA663069@ziepe.ca>
References: <20261023220030.GM3977851@ziepe.ca>
 <7843a833723e3aad40f8fc4de3a83f5a5059280f.camel@intel.com>
 <20261103005851.GH3889730@ziepe.ca>
 <au5LCE1jau0yDo5S@intel.com>
 <20261109171236.GP663069@ziepe.ca>
 <cbef9bda9241ffe98652172edb67fab3eb1c35ee.camel@intel.com>
 <20261109234252.GR663069@ziepe.ca>
 <4c75b369b68c98c5c35e296895b6935342dc7dc1.camel@intel.com>
 <20261110131114.GV663069@ziepe.ca>
 <avNfZ0lLl-OrkCHs@intel.com>
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
In-Reply-To: <avNfZ0lLl-OrkCHs@intel.com>

On Tue, Nov 10, 2026 at 10:16:07AM -0800, Peter Fang wrote:
> > It is not local quote processing. This is labeling data properly so a
> > verifier is possible without the user having to manually and directly
> > inform the system what versions of Intel CPUs and TDX modules it
> > should expect to have.
> 
> With labeling like tdx-quote-sgx-1.0 and tdx-quote-eat-cwt-1.0, and
> enough knowledge of these labels, I think this can be achieved.

Yeah, that's all I'm asking for here, and it sounds like the magic
bytes are enough for the kernel to deduce it and pass it to userspace.

In future please transfer labels along with the blobs through out all
your paths so we don't have to parse magic bytes to know what data we
are holding.

Jason
