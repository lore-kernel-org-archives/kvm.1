Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B601F5013CE
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745896; cv=none; b=gkGBZwoSKMauX2asrSIEuF+swQvv+JepbOOIlQIXQ8mT+LqWZBJNSYKAOKhzY5pXqXLIdPdDpnn+JRnKX9zDfnlN0AzMR5quCzdYE4aFY4lZ8615TPS6l94fb5FGFN0k4aPYLMvUSwMk/rfGdl+NqYb6TpqvAVOyiv21BC5lASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745896; c=relaxed/simple;
	bh=NKTBErfeYAFwMh88Ax3YpWdTdtUhF2krkTjr82UCsCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppjq/JRm8nP8UbK9Cn1Y2t192hFhOwpEXlmQMKZBkI/bB54uVA5/+OxahqZvqIWBPPZ0uoqoawwwN+zxz8cjDVurLDFBsLxzr/f/fBoxhpHr6XqHFrQ4e2LTog31tz0wuIaR49FSVcRJOOSzvYZ6f5VSWz5heZ7dfmbToZtJnUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HvIftuR2; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HvIftuR2"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93a2a8c29c4so94013285a.3
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 08:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789745893; x=1790350693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZPX/IExiJfHeeEYWclzoLImRY6MfSvptPhsoDuS3euk=;
        b=HvIftuR2XxPVL+HIMJMjzbSSZ6wm21P8hdfAYgWfIAQphUpppET0T6JkIHTWYROW9W
         0FBMEofz4OsHm/fR7flABm2uZr1RTBShlUypswwdOV8L2W/77dY2fr52y4jL+hxLX19E
         Bly42yJbRGsO6T1gsUT3KqM2oYnLMu+ddlCGrKKtOUtD7frXwNHl7+e0kpsttLEfYJJd
         M8nxxjKn01U7qrBCHanOn6MGdwm+6RRnaF/BKrmzgTnf5O1R3Lt+NanpG/0tvZfwvJI1
         WQysTrpfYLsjfayHWIdLQDljz26GLI4s+usmTThAhxKvBbc8Z2QlHqWJ6nqvZV+x4Mus
         FEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789745893; x=1790350693;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZPX/IExiJfHeeEYWclzoLImRY6MfSvptPhsoDuS3euk=;
        b=SZvYZE9T97NnfBz4Hj9FwIyDddk2GxkdAU3WZShne7mk7mrRbNFV7kBX49ALJnz7jE
         wh1Gvjjc3f8GreA7WqeAkMru72UmmKUybypI0otnOWQQXgmpYFSx9rBjoLR10KWoY1wn
         d3lDJ9S5cNm854zLkWNZY5Pcvqzwvc+nT7uBDjUe/50CzEF+6XwCco+unB5H8QnkA9Wq
         QBSUJSx0XUgZFwEO3PjujHGjehL9KycGL+D38Y+j6s9PWzQM2VU7M/jPmNuwHEyfhjxu
         gkCLkCMmyhNv0GhC3CKgLmoUuANthFKsrvmd2rBfvjqpt4Y/RkgrO04t/BOpGmooLvza
         rNTA==
X-Forwarded-Encrypted: i=1; AKwUvBwbcf+ejb6+afN3xXkMoSVtEqmtIZxQyfHIzZ3h245Ai/FNaQJClbV4g4Kwj0lq9Quuh9g=@vger.kernel.org
X-Gm-Message-State: AFuF++lDqXBCFzEbVFLfEDtgspuIliJ3xEVDtNV96IkNrhungH36bSUH
	yZnWRzvvWfkIyMfbzM9l7mxtoE93xUoLP3WDqv+jo1ak3/2vsyt6eYsqkhiyI+RRr7I=
X-Gm-Gg: AYBFou1QVRI67/vGfzpUR0XWN1SGwPskcZySj+EVLNxSZr0Rfqpq+aV+b/E3Xo5DE2n
	OTNltzqHLGUr/Tif4+iDq61ruoLCGlqz53gWSBZx9Xspt0mF5rBNL/k8JeU98Z6VZKyWUl/Qkap
	549RBWwesN3i31o+fAAcjTc1ewtwQcs+M3FH8M8rR1bf30bfooVgEiHVN823xDfiwxd+BKD/eHw
	oIb8iA/Kc4WnFHDMGy324qeNhSve/w53eJN04mrmwWDOHsBki0C8XKh/bSca8mIt8ElQvKZYXHz
	DWtxwQyRFl/c0Bz1wUj0h66WujJ1nbKH5LRn+g1vJQuHm/69J4FIPP68WkBdmv2tQ8fYEZ4Xt4q
	fKfiHme5cYHQBD6YK8qjSR9TSSg5asEI8z5vxqvp+r5UzyPiOO9MHKho8vlyWWtXLmlI9ghESR5
	nLZaS09PRW5RAYhs+Tl8tIqV4ognGQqWosZ7j7iIGuFi5gEo3KxGJ2O5ofzCug7d3UVlD4U1/F/
	4XCNUrHkUii0nm62JKEcn7V7HKuwASc/OAJTnNGFrEhLW5yd/zoDkFynLaVD838Ntw=
X-Received: by 2002:a05:620a:6493:b0:93b:d7a2:83d3 with SMTP id af79cd13be357-93bdca2333amr399972385a.66.1789745893495;
        Fri, 18 Sep 2026 08:38:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0e508a2sm165680285a.11.2026.09.18.08.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 08:38:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7afD-00000001ssc-3a8b;
	Fri, 18 Sep 2026 12:38:11 -0300
Date: Fri, 18 Sep 2026 12:38:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	x86@kernel.org, Alex Williamson <alex@shazbot.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Borislav Petkov <bp@alien8.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tony Krowiak <akrowiak@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] vfio: Use file-based reference counting for KVM
Message-ID: <20260918153811.GE11599@ziepe.ca>
References: <20260903-vfio-v2-1-ef4cd4190ae7@linux.ibm.com>
 <apmsZ3j0mtZq4Lp9@google.com>
 <20260918134543.84754-B-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918134543.84754-B-seiden@linux.ibm.com>

On Fri, Sep 18, 2026 at 03:45:43PM +0200, Steffen Eiden wrote:
> I sent the changes incorporated in the main series[1] in 5 patches:
> 
> KVM: Introduce file_to_kvm_<arch>() infrastructure 	- adds the macros
> KVM: Add file back-pointer to struct kvm		- adds the file field
> KVM: x86: Use file_to_kvm_x86() in SEV
> KVM/vfio: Use file-based reference counting for KVM	- the swotch in one go
> KVM: Restrict kvm_get_kvm/kvm_put_kvm export to internal KVM modules
> 
> I needed to do the switch in one go (i.e. merge 5->3) otherwhise
> there would be conflicts.

It seems to me many people want this vfio conversion, can it try to go
this cycle? IDK if it can meet that linked to the s390 stuff?

Jason
