Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316621;
	b=HVatHRTkz+gj31gXm/7situr1N1FzS/+80TdAw0C6ztWgKik6a/2QpTHSSZrySUEIioe
	 FRdO3Lp3qx/XPl51zTkqvGcxam46bBvSy3fVnDbM4diwNN5C8UmUcMV1Ud9f0sErPQVCT
	 IETOpF3aqpZGzzvkqu2VNmMxTLOEdRbZfx7iamsalhE/t7Gd3L48YjMm4rKQC28KPtgV/
	 +Pj+SFf72Q6te2yaQUtWTG+B5qKarr1SBI3t8a1UF8ZOjijdSy91Av7RWiJ/nn72NNE6V
	 vJqVSeUrIZ5ZWVaadbV1UQHVWbChnsrm5pleTXHdhDal2LH9P5WyPTEovaGAWnF3jYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=S4nJQhVDKToBC1JLFzd4gn3MfYBpNet9lByhTADIBpw=;
	b=fdRRkTkd/K47Bc97Iy6gJ0ErTGo6ovfkOHJYHXcg2mXvfbgzufb1YSnv36cM1IbcbwAM
	 0/vZwC6rwiJlWZI6oqhE/FTAe0jYJcLBxrgNAbN775lAMKpx44m9bgtL3yTCPejS0rtdo
	 LEzbob+X+KUyTimO4Mq6iYdoLQ2jKT1p/8M0/AC8JltW0Fukx8Tnt53ZRYeD1nFvBdRug
	 IhJzjNtFALV98ezLBs/AF62DDEIyOdcZCPIS9IUhhg1kwGIkeNR6NWfYQmuZ3mTVT+DeK
	 OLAcdVhmfNr7vIYQ1QjUMH8MHkdbYY2/BKN4ZYsnff+irmL8jg38L1BSVoAk50oSu/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=O2E1Zioc;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE86F606A332
	for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 13:17:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE86F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=O2E1Zioc
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-91ccfb88e4dso24343156d6.0
        for <kvm@vger.kernel.org>; Tue, 10 Nov 2026 05:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794316620; x=1794921420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S4nJQhVDKToBC1JLFzd4gn3MfYBpNet9lByhTADIBpw=;
        b=O2E1ZiocM1QEde3pbXv6YSzgLeQ/A1L6P4QUUGeLVnHRl7hZp1Iufjhb/HRQG4n+7k
         8gbRJK3bxRWNnttv8/vLyQ3i3EwYMspqgm678+6sjnMgVOzLvgYizMBYpjB1RYobZ2f2
         uKTP51hIos19xstFK7UzI66ziSHzX7bnS7Rd+EAu+EjVQcYx9PEcuxf580PwsOZKPLoa
         pPrkKoaf2unACk3+vtCkCw6RqH8fISr8QoIpF+urxZWvDCVcwqQ6qVHpgOVf1z910HQ6
         AxX+WnY+cYjMRUSGOe9q3QgIy/OxyD+YKVQRGFf6qMbv7zRbhsVkmn/qS+KkblXSGnIM
         IHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316620; x=1794921420;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S4nJQhVDKToBC1JLFzd4gn3MfYBpNet9lByhTADIBpw=;
        b=VHjJ9+Zzz8H2IP/WVodRQvrGKpd13zpZoJmt8n2//92RblLYgstRlAjUWf+8FruSjF
         D2xhpwMByauMm+XYTaqqUAb/9xrUdnaAWvccvIBns2WE77f0eFyEp0ZIb+MPsRK9xSS6
         celiz7cRH/kAA+CNThQGTpRM4CWyPVy2B5wdjL5UAp6stp4mIgVYHYLW1nPKTAfrItJD
         Q2AEjyKXPf/0vtWodEm7Uf2I10oQeogK1c+L2qtw9J0osf1vEIzq6RxZ4VlQdQ9mk8yg
         Ee2Dw42yZFkkVv0kWV4nqHibqVJOKwGbl8DIPWTpXYcaUCl8OhtlDpVFzcWKI7DbGR8M
         slhQ==
X-Forwarded-Encrypted: i=1; AL+hErEx7UN1WocY83UAc704mBmNTuQodP2DHOoBjXg+p6NZjFwNDzoWfaTWMnqvDBWIDkJwnTs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/KEySThMq1+5rAsrwKjrvJTTCQpQ+8DFtsfmJ30Hv2H30k8GzY
	nj0bXdV/SsC94T2yByRCISiBhG/8OGE+yrRzXnkfR3s80iaQSq+IrJ7r+f9ovC8iQBM=
X-Gm-Gg: AYBFou0j+0rkZSk0uB7zqSqtviVGHJRp79FckCqZiYJ/tX+dx+H50uDQwG1qqRyb/Bf
	VKUqXSOWEbz5YnhcWv09xjBsU6nid7yYnxySzUea4Ar2xj2SeUwbdsMLuSXjIlMThsKdeyIUapT
	grUVC16/kyYiGpqCAzObGFGBQih1n1roLpXcnvHMKQ645xfY7mJLasunOLbkHIPtAYeXdSYrPtI
	TEAr0a7Z6e6jlF5bTM6D0clvCS3n5LYYCxubWHKvqAJ4b8OOhY946ewXUo3r4jORD/SDcEd12gW
	cIPYAW6ImC42WjR8SsOBrZEISf8nXNhm6xXbS/yDR93eYi4WCGql9KNC9fypBoFa/9eJc08OJJl
	7jvegZPO8FiQkMu81/6HhazK78SUW1XtXp+iM9E6h7U9oQhfGFrTfX19Y9JlzIVzEBcoM3w66uo
	3X9xcO5R4Sue3Xb6HbGvwNLy4g20xNC83C3uArZB2glr7C3Sx84lOJo22s01xSvokAmSxeRk4to
	u7SzjyrW5uKx23541Hi/8Wz/m2PYYZ+T4qdk3wTnRD749s8XvVySXCG8dfiaeNZ1Pb3FqBna2jG
	FA+7n4gCV6C/+K9h5Ff66x9DT6IOAiPbKfhfSrxkJ3LBpFwoXgy0gkY9tu939EzkP3KnN569ISP
	vOtSpbv/T6Q4=
X-Received: by 2002:a05:620a:1724:b0:942:e4f7:6104 with SMTP id af79cd13be357-9479f3766f2mr439618585a.55.1794316619773;
        Tue, 10 Nov 2026 05:16:59 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e61c333sm220869985a.3.2026.11.10.05.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:16:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQlic-00000005geL-2PDT;
	Tue, 10 Nov 2026 09:16:58 -0400
Date: Tue, 10 Nov 2026 09:16:58 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Gong Shuai <gong.shuai@sanechips.com.cn>
Cc: tanchi25@mails.ucas.ac.cn, alex@ghiti.fr, andrew.jones@oss.qualcomm.com,
	anup@brainfault.org, aou@eecs.berkeley.edu, atish.patra@linux.dev,
	fangyu.yu@linux.alibaba.com, gsh517025@gmail.com,
	iommu@lists.linux.dev, joro@8bytes.org, kevin.tian@intel.com,
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	palmer@dabbelt.com, pbonzini@redhat.com, pjw@kernel.org,
	robin.murphy@arm.com, seanjc@google.com, tomasz.jeznach@linux.dev,
	will@kernel.org, wu.fei9@sanechips.com.cn,
	zhao.qingye@sanechips.com.cn
Subject: Re: [RFC PATCH v2 9/9] iommu/riscv: Add riscv_iommu_attach_dev_nested
Message-ID: <20261110131658.GW663069@ziepe.ca>
References: <20261105144944.10193-1-tanchi25@mails.ucas.ac.cn>
 <20261110115137.184160-1-gong.shuai@sanechips.com.cn>
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
In-Reply-To: <20261110115137.184160-1-gong.shuai@sanechips.com.cn>

On Tue, Nov 10, 2026 at 07:51:37PM +0800, Gong Shuai wrote:

>   2. Use the guest PSCID directly, but allocate a separate host GSCID for
>      each vIOMMU.

This is the right model. The viommu should allocate the GSCID directly
and keep it for the lifetime of the VM.

>   3. Share the GSCID and maintain a per-vIOMMU mapping from each guest
>      PSCID to a host-allocated PSCID.

AMD is doing this because they don't have something like a GSCID.

Jason
