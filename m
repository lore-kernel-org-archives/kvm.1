Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235796;
	b=aEG/6b3jmC37zNgukPhSthgNM+Nq8GFn5KY0wHLz4t2vkNpiNSnums4R1ZcW4K39C1Xe
	 UpM5p9mLN2pwCiZR9wdDDaE8RcPlbSgEpnF/7HTjti3E140mmVJxr0QOo7w6TkgmlBPRw
	 pdzJMqEv9rcUkPoRszLMHh22pJ8lfwhp0b+cnQ21UDdtfNCCHDwHoIJLnxIl5Bh3BYl+G
	 JoL0feWK/7JkI2ow6Y6GX5y7DFk/pZsQKwN1bNLZ048AwAkzovA80cbqW+AHGitTmqInv
	 Gsp1FM1V4BZxGbuhLpnMDtJbMKlzwaFEGEsMMmD9nZPp7QdHZgHH6mdvLodhxrV3xfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235796;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=4RSmtcwNoe4fGrMvwANPOQwGQ5KlD1ttYfRV5b0y9d8=;
	b=uEDpEl6vh8AW8+94yHJsupAuFcA1SBuhk8avoPFQ/liJi/+1Mn9AjAJgT7khIYolzmid
	 FDsAsS+F94jqqJRScgdp/r5Rtvm22+H3h4odip68qrp8znkUfTcOa3JK9ewDvorWWj6IS
	 7X0RGwUYi5WnPdTOaO9PTu4v/c86Apoa//zu752oAMg66iJNcSnlORJ4GoONbNYB21Vb5
	 NN/t07fL+Eg0gLuRh+EN4Q+p6ilihM37PC8i3/v5O37Ezfz0Q2t5FERUwz8jBO1h5YBqO
	 8Z93qKeFJwNSUb6g0WwSSv77dT7JKxhSQQWDCaopY8wuuqzHBNaZ6VkuqRmbGovLpjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oKQpSjyp;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31893606A323
	for <kvm@vger.kernel.org>; Mon,  9 Nov 2026 14:49:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31893606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=oKQpSjyp
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5351d76e1baso9262241cf.1
        for <kvm@vger.kernel.org>; Mon, 09 Nov 2026 06:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794235795; x=1794840595; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4RSmtcwNoe4fGrMvwANPOQwGQ5KlD1ttYfRV5b0y9d8=;
        b=oKQpSjypJV/8BYimCUbLH/doWtwNr2rzEx+IZmgBxwGsp+wz24vzDEwUf7iSUD3qaF
         wN7nu5QreOwFpRBsrxAUfaVDwa44a0HXl5Q/l7Bp8LPEd9h4z+Olpjm+ExUOe6Gcl/A+
         tboUQG1VNVwmnu3dNnuxeX+CH5YL0grbY+79fh32g4rlI+XOgySVLsjAyY2mN9z2l8vI
         aZ9TxRJeRf9z4+ZEAJoOTGh6D9cVuvWTpfIBKUz1KTj4N0w4Lfe5k+8nefwMUOrunz0N
         r47XGgW1pVlYjC8lgpJ4oXfFTY3Cq0tCqsYCWf6J1n4snk6fquYK+ivMFCTQltIN5XQb
         GBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235795; x=1794840595;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4RSmtcwNoe4fGrMvwANPOQwGQ5KlD1ttYfRV5b0y9d8=;
        b=fi8QLZrxBct5hzRSvjhfalwgkiJZ8jYIleKgVwQGlota0ycfuE14w8/ZihvmUU6OBL
         QfbkgJ4qomFbXJtILxuhVbbHkRonjIWLWVdifVRiN1RLc9uebV2KHbF0oWVq9+vLISP4
         pVQryfs7LzDVd/GtBN8ei5nuUDVGrAgf7gGmXyNOziEs+1D1bmfLKXN/uiKO4dpgj2YP
         afj8IVS8yeR4WByo+sdnGUslHY46+6huGYeP9/X9iGpKWeQaHgwvHfXXpnVz7uduA9Hi
         KUhoAUkDrs6GSwp26X5x2ChTMkSrHFIQV5KkHT6sjucuYQH+YjohhcgscORfc4ZoiX3Q
         jPhA==
X-Forwarded-Encrypted: i=1; AL+hErGzB4LMicxaaHoUuyEwMK+mTlW16IHVDtGuwsw6jaqFNa3POuNRTPg++7mtD7f1WYIXowo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DkpmrqSr50smwqgorNmiED7e5mgE9bVUOcSs3RwxRc9JEFyYs
	fRsjoj51uFD6CkjmCs+0OzpCCyUVapoGSh2iEIj6h+oxh0x558m9RxE3nuV8P3SMe9U=
X-Gm-Gg: AYBFou3FkJHMuElVuXYDD5EYLNpd29zLzTsGcU0Cp07oXEWeKCHVYiMjzxwkhUkwoz3
	vHjNkrdC3fTac1nJ4xrJu/wA7kzC59LP2q1CJFHoKvqEtr3Rkc0E5lIUvOt4VkLkBkmouli20yP
	ePpEmOb4hXDsjvjhq6vYME51MHVfl8SiuMVu9kzSWJ8Q4n57xoPUn+P7AEg8RejdhUNujdEMSEa
	HcH5X5mtt/2vIhYqe+f3YICCJXiapUs0QVmOA7T4wDI+mQ+ZJnpGbofovWvOc75yuGS4ob6cDx2
	Rwz3GAwt1Q7YqVUI/N70+Fi6hhtw6VpgxmpXOoETXjRB9Yv1gFaSqj+xDl9IRbo5+rU2erR6/hB
	5zu90gRMcEv6zlK8YWc9QtszTkQ7SaFAgnGHO1X1n5RSe7xys3wbh74m4g3eeyhZyHmsbS4VJBK
	sziHvh3y2UgKZgnUN5weXqylZDal3JgEJrbCQfgHI4rO8z503zvMmW2rj3D6VAGcguWwJCYogAn
	ffJBLvKALwxuil44VvyXd7JWoh3WW8/SuPy3QZpkcafIRuY2cK78pfNF83EuGbY1dWHR0yT47Oj
	MrIjl7vc51NOKRrh42gvIj5HYqZ0J/wlnItJgrLKQsJbGGEVFYWkhs34VJtKWXeSO9Eyb5KTIWv
	hUpzn8Iletw==
X-Received: by 2002:ac8:5fc5:0:b0:535:1740:d334 with SMTP id d75a77b69052e-552a21effafmr59868371cf.3.1794235795175;
        Mon, 09 Nov 2026 06:49:55 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5525e68a565sm42604271cf.0.2026.11.09.06.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:49:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQQgz-00000001QsI-2Q0x;
	Mon, 09 Nov 2026 10:49:53 -0400
Date: Mon, 9 Nov 2026 10:49:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Yuho Choi <oss.patchbox@gmail.com>, Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfio/ccw: Flush notoper_work before returning from
 reset
Message-ID: <20261109144953.GN663069@ziepe.ca>
References: <20261106191029.469837-2-oss.patchbox@gmail.com>
 <4cb58287-4273-4518-8cac-aa3056dc28e2@linux.ibm.com>
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
In-Reply-To: <4cb58287-4273-4518-8cac-aa3056dc28e2@linux.ibm.com>

On Mon, Nov 09, 2026 at 01:38:44PM +0100, Christian Borntraeger wrote:
> Am 06.11.26 um 20:10 schrieb Yuho Choi:
> > vfio_ccw_dma_unmap() is the DMA invalidation callback, which must unpin
> > the pages covering the range before it returns.  It calls
> > vfio_ccw_mdev_reset(), which raises a CLOSE event.
> > 
> > On the normal path fsm_close() calls cp_free() itself, so the pages are
> > unpinned synchronously.  But if the subchannel cannot be disabled or
> > quiesced, fsm_close() falls through to a NOT_OPER event.  Since commit
> > 0c11f61a876e ("s390/vfio_ccw: Move cp cleanup out of not operational"),
> > fsm_notoper() only queues notoper_work, which is where cp_free() then
> > runs.  That commit flushes the work in vfio_ccw_mdev_close_device() and
> > vfio_ccw_mdev_release_dev(), but nothing waits for it on the reset
> > path, so the callback returns with the pages still pinned.
> > 
> > Because notoper_work runs asynchronously, vfio_dma_do_unmap() can exhaust
> > its 10 retries before cp_free() completes, hitting BUG_ON(++retries > 10)
> > and taking the host down.  A further CLOSE cannot help either, as both
> > CLOSE and OPEN are fsm_nop in the NOT_OPER state.
> 
> Does the the iommufd backend have the same problem?
> iopt_unmap_iova_range() keeps calling the unmap callback and gives up with
> WARN_ON(tries > 100) and -EDEADLOCK. So that path is also fixed, I
> guess.

Drivers are not allowed to refuse the shootdown, it is broken if
someone has done this.

Jason
