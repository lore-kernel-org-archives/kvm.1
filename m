Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D4499F25
	for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 11:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789731368; cv=none; b=CJuJfjVKPKm5wfKcbVdPyYsEIR6iA5VonMAQSItZyzT+BOq/AhGpFANksaBiprv5y8QAf+CKZMjpqHJTGAhqrNWiR2NVH6wJtdV8Sqss55LmjSvqQp+SdQf0bbI61Seqa+9cxjz6dbgk7jGa34lgroEOaAfKg5XsPiQPGSVZ7ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789731368; c=relaxed/simple;
	bh=rtN8qENpaRtifWq0pL9lCQPDcNEtXd9dpsU5YPwNW5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srkGiOf4cNPAJyo5h7uEQ09cmy9HBYSXOTiCPZaD0dQkZ0Bj7T+6G0Frv+J9d/koUlsMDnIA7KRA6IVFfp406B8RM19nRkMXSv4GhfWPy9YavQuLZxHsIUbYjDlW5/IhHd31bkPVo8ovMy854TTtpqTdirDaBsAvw/cGtFd5VoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdGTB7/X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jcyuBUuh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdGTB7/X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jcyuBUuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789731364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xKV/nX0BC4tLJSo87et19oAKhXTXN7V8XgQQafKKWXQ=;
	b=YdGTB7/XxN0T+FwOfrHJUTpaXJTNwKeHeklA2zmFBW7DcImNVxWCRd6Nwhzv0cUuAhWI02
	9uUZJrz5AvLlTJfCmBikgoShdPJWXIy1UkepbQpa6yt0WgUUmj445Cs40wFy+rVN7iwRs1
	ArfWwvWpanPG80bEtLD1hA0TcYIPi2s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-17KmlOf9Pxif04Sgq10n4w-1; Fri, 18 Sep 2026 07:36:03 -0400
X-MC-Unique: 17KmlOf9Pxif04Sgq10n4w-1
X-Mimecast-MFC-AGG-ID: 17KmlOf9Pxif04Sgq10n4w_1789731363
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93a0050a554so149437385a.1
        for <kvm@vger.kernel.org>; Fri, 18 Sep 2026 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789731363; x=1790336163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xKV/nX0BC4tLJSo87et19oAKhXTXN7V8XgQQafKKWXQ=;
        b=jcyuBUuhb917/j5HfFO7ndeCTWbqtuJnv0CtvmuF6eQ5yow8BHda5X0u3VcvXjj+57
         FoADFzyUXmDxbKvSSbh3zbitqIEaHBj+mrF4OakIehjvXYc1sV2q7XY8HtIMntytWHD/
         vEoupl0RssASc1n2pQq1V2jyl3EhZ3C15ZPWWGLWu/DEYWsSPNPD2GXEXPIwFLx/Dm4N
         ty1Ol1gzXQVaMQ27Rv9nh9cWZjy1i82T/L/xodtKD5aek36iHpeCXqHHLX9dP/4bP0fQ
         eQPO6fUU7yfPLnBG6yqziC90963B7p4gmw+Z9Z6tMZSTc8fWKjfH+GZ/exoMw/zAqB+N
         jFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789731363; x=1790336163;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKV/nX0BC4tLJSo87et19oAKhXTXN7V8XgQQafKKWXQ=;
        b=Z8dq2EcamuFUtoFCQEgIJPrGD0yyM1Og731uIYwZlKuXXWhPPMxTSHkc6yMHEX//DU
         LDvvM/Q85tQYI9ixA8plEaG1aUCoLed4o+7jn39rxsYh4w3lWSMBP6cgGhxaR/wVO1YO
         VsbirrZWvTsGbxqH3TXTRXXS2TZurI/e1eogKb7Qhxulq5CLslQEyYlth3VGVEI1SNR9
         YnPKlnr+ZQngkA0C//dfi2rX6Wywah2ZgXi+zS9ucKU81ZmebLlh/VagvlsvH02Z9HFJ
         nDQXMAl4FJLeX52DgyqpFbuwunu9wtvHw1GUF8xjU3h7Wh19xM0aHdp2R1ppxNRR8WDn
         NQzA==
X-Forwarded-Encrypted: i=1; AKwUvBwKFlGX8hOn7E3pMh7IckP3O+ofZSeSYc31SprCZARw+CfaslCM5KSt/FIhL2HXB3Bqi/U=@vger.kernel.org
X-Gm-Message-State: AFuF++n3NyLc3M865V1wCaTwVD15B6XJuraxdZiN/CXa89M3pUkRQnN4
	OnqnOFZrJZEBGN/IxHuPv2dof3QdlwurueAjrvDqnSSv75nyRoS619iZf4dseWfQ4qDwcYkSgEW
	7dxOk0n4ROzehK6b141PI2Ws5ukn+8zleXWjzyIShqPxn0v0uy+TIvQ==
X-Gm-Gg: AYBFou13V8ik6RnQMdMxd+z+nxnvFaz1DOTv/JVJ+/PZnPAH8xvK90PuU1Jcuqnv7xX
	2nnb5mcqpYqCU8geMXDB17BOI00iMswBSMAvntDnd7D9T7utAlfKqIOT/TxSL1TTP7Ymalwj1ZR
	9+ce7K5CWrNWdywl/Lm/ZzRT4KisBC2/uNDs3d0rggi/p1vdu853Ue3Pn09rvNkOakeZOE7Z+CG
	wEnJ5Z+vYThYltaBWrjjfAdfdCrBMcjsPy9nufsrfm3bUznc2PESGA9zYCEo9qjcD/rkLQBtJbM
	Xx3UPfa0fSaBpKeeHAGTr4l5eJfbUy3Bmp6IkXGlyud20qq1XIIeZlxC6wvPP55Mu2+H
X-Received: by 2002:a05:620a:17a0:b0:93b:d79e:18f6 with SMTP id af79cd13be357-93bdc7ac02cmr256114285a.57.1789731363047;
        Fri, 18 Sep 2026 04:36:03 -0700 (PDT)
X-Received: by 2002:a05:620a:17a0:b0:93b:d79e:18f6 with SMTP id af79cd13be357-93bdc7ac02cmr256046385a.57.1789731353730;
        Fri, 18 Sep 2026 04:35:53 -0700 (PDT)
Received: from localhost ([174.91.117.74])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9125800f25bsm10381296d6.15.2026.09.18.04.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:35:52 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:35:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Tony Lindgren <tony.lindgren@linux.intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Fabiano Rosas <farosas@suse.de>, Jon Grimm <Jon.Grimm@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Steven Price <steven.price@arm.com>,
	Anup Patel <anup@brainfault.org>, Samuel Ortiz <sameo@rivosinc.com>,
	Jakub =?utf-8?B?UsWvxb5pxI1rYQ==?= <jakub.ruzicka@matfyz.cz>,
	=?utf-8?B?SsO2cmcgUsO2ZGVs?=  <joro@8bytes.org>,
	Vishal Annapurve <vannapurve@google.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Fang <peter.fang@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] Documentation: KVM: Add live migration API
 for confidential guests
Message-ID: <aq0iC5z0HFn5Rb2D@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260831071304.762939-1-tony.lindgren@linux.intel.com>
 <20260831071304.762939-2-tony.lindgren@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260831071304.762939-2-tony.lindgren@linux.intel.com>

On Mon, Aug 31, 2026 at 10:13:01AM +0300, Tony Lindgren wrote:
> +:Capability: KVM_CAP_LIVE_MIGRATION

IMHO this is slightly misleading, some "CONFIDENTIAL_" or other prefix
would be nice.

Thanks,

-- 
Peter Xu

