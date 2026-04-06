Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD632E6116
	for <kvm@vger.kernel.org>; Mon,  6 Apr 2026 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775514872; cv=none; b=noF8jlR+VO+mG7z7VcW2s3C5vXjiXw0+lRdZPddJIvExGKJRBCUelHnmXSuo8Ju24/9oc0qfVaqRdZj4bzu1/jRV6bUzeRXRVvUnzfYBIwiBBvmHF2GQTFVlpTZrXBt21wvZkvCK8EUG3Ur7KPtf1a/GSsAvcKRDSXFjR9Vbu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775514872; c=relaxed/simple;
	bh=WFzGTZsHMRrTZNHScHgxIGlWO4YJHCzfNsyWW6bAa0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFchBa6rLdkVwQ2a8+/yt7GhRFvWTPNU2WD4xeJfRRkWGOQ9teutK+644MPwC4yuliUiO60N9oDf59VB+wTGnCQQBf9OYJgbbtD18K9E2phD6XWsf0cVWXl4TDdQ1FBZM6FynzXKzmW0jyJhmXZgQZjzNwhgKrJVExpNrNuu/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YSRTfdmn; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YSRTfdmn"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8d4ba1518afso318294185a.0
        for <kvm@vger.kernel.org>; Mon, 06 Apr 2026 15:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775514870; x=1776119670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0zUHeg6fURLNHDdB8I0M/mJi+OaPPUAu5+ZEMzIxATo=;
        b=YSRTfdmnrMCJRvajaSzETN9qzyr59D+F139hJZjlEfO5Tr8WT1S7wCPibje+yI2EJR
         C6BwWwH1dvPrFLeVOfkcXg54a7WojhOzwEp2gKJDMhxssJuzTir6f22mH+pz5GuZ9zQh
         0eWMubUbMojWmODCdrgxLn+A1fbkaF1claWLNc6Xq4kq+5mwMuzGhTLRbpabbgFBGTmi
         uqU44ZdZMEyfPg9O1Nc2E4lXUNzc728pG0Gl5m/xUHRKWUr2vnjoGpEC2pBuff9tV91J
         Ldcf9QwjjbfXA3yxjTDho8AXtp4AaoGTWSAcat8FEdLdri3+i+5/3KwzvdzmuCZEpn4O
         roHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775514870; x=1776119670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zUHeg6fURLNHDdB8I0M/mJi+OaPPUAu5+ZEMzIxATo=;
        b=QyyU6UIwtKn9D/tYekNSgXY+1oQRvfdJ0TqqW22Tn1jfIkQ/M2YyTZX1d18mHZ2nkC
         IMZokwiR/b+4syiZcyRbZS6FvzY3k6w88LKY5X+wFc7IAxtO8qZw28369byUPgsXNMAG
         r2Sk6YsIxf9q6/TZSsQnLERrvklGKkTlR0SCP8VoCs3oPbDEGxZN4hy1oIHAIoNcfccZ
         ghhVZ4iF5BbpTH9C4xfntHx6PIuOWVUUV2dMlWfmuDYc+Nj5XIcSl86pgaTVUijp1hkO
         khmqCIPfvuoqSpulWEfUzJSi3viHDJSXRDAaQ/K/hLCI1j3a0zzQ4gA+8yoCB1+rCEy1
         UljQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF1dFC6o5duX6/IQyrXqlF1zBhsOnOEkkOdTG7H3ALTNN6O5tEJsARrcMswXJurZW5LZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYEm2/AEpPSCWpF69iekGI7nZggOK0YDm/vqgmjWdr0YifYzh
	Zsu9g4BcTKaJ2ahuk6fqxucuCyf+5UgcS/64Uec22/QzpdgF8PZXH8nG7a5YLELdQr8=
X-Gm-Gg: AeBDieuHvGZJlNto/LyeR18w4pXoFIxxYYoj8+ET/HeB2evFOcuLtKjPuWSumhn28yC
	6jhihBxrqA2UIEze32WCg3F/aCzOFbLP87AgkpqLfMmiTlTVcrikDZ+/ysMQt+t+HZX7wLo3NXF
	DAxtzfZeLi9WtRcyhXvItjkKmlRabyzZGB6I2KRTGpt347wCRP6q/5weAbRCN+2nn30uIAd5IQZ
	ZPfxHWGw4HpaHlXheAQYd2DN2KgzbiRhNajmSR/sIeEwAtn+DhEY1Tp9LyFMvmyzy/CGMMFVPxe
	lnGsBkRqfjW30xSRY+4RGVGcsFlbRKidD4Feb2g/AoQ47YSP7FC0mFkcGF+2R/Uf3XJ/GtfPnGr
	sMVtRmWaVIN4NhmBZRw5L2kz60Ox19YztqUQYtp0juMrd+8Kmr1q3h1CylGNzWICBknWbWYajr4
	a51/pvCjgm2MqhhzwNh7StqdCcYfyP03b5hhPCygk5FSefxJbrkokN/IK9U4WL49+d6JYEPQ==
X-Received: by 2002:a05:620a:4096:b0:8cd:9584:6340 with SMTP id af79cd13be357-8d3042ce1bemr2183566385a.43.1775514869776;
        Mon, 06 Apr 2026 15:34:29 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d6339bc438sm600898385a.26.2026.04.06.15.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 15:34:29 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w9sWa-0000000E5Cx-1DNj;
	Mon, 06 Apr 2026 19:34:28 -0300
Date: Mon, 6 Apr 2026 19:34:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
	Vipin Sharma <vipinsh@google.com>, Josh Hilke <jrhilke@google.com>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC] Observed lockdep circular dependency in SR-IOV paths
Message-ID: <20260406223428.GK2551565@ziepe.ca>
References: <CAJHc60zTBn9xMksi-_UBK=W07rp2vGVZ9ToYhFyadNz4zCVHAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJHc60zTBn9xMksi-_UBK=W07rp2vGVZ9ToYhFyadNz4zCVHAA@mail.gmail.com>

On Tue, Mar 31, 2026 at 10:23:06AM -0700, Raghavendra Rao Ananta wrote:
> Hi Alex,
> 
> While running the vfio_pci_sriov_uapi_test [1] on a CONFIG_LOCKDEP
> enabled kernel (7.0-rc1), we observed the following lockdep circular
> locking dependency warning:

This loos more like a class issue, the locks used by the VF driver are
different than the locks used by the PF driver, and even though the
devsets are shared a devset should never have both the PF and VF.

Maybe shifting memory_lock into a different lock class for VFs is
enough.

However, I think it is a bad idea to hold the memory_lock while
probing a device, I'd prefer to revisit f4162eb1e2fc ("vfio/pci:
Change the PF power state to D0 before enabling VFs") and change it's
logic to rely on a private flag instead of pci_num_vf()

Then we don't need to hold the lock any longer than just setting the
flag.

Jason
