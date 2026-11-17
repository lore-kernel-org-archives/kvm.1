Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794958273;
	b=hWpaou6UUSRmMZ9gGYxDfkKtnL+8g6voLG7mPmUoDXjmW3f7GufBuIghJUWPEfrV3TWX
	 0eLKK2b0XOQfCrF3qVd5g/K48Sa9lYVBj30OTN3Y+ldZzZdcGMAFTwf9qklGlH99u9zQp
	 Ue5vxIbr2Q7d5g+G0Z0Hjv2z4Zsl5qdJWf/2CQTM5rU9ci8VzTk4ploSGFOj1OHoiYcmM
	 UZBUF7JRm4zNDGtJNeiQnomUjeeOvNIUwpEuoGj6Wmz7/bmWKjOoNIY4OsWGtwTGYUeiI
	 UN/DSHgJIrlGjm/prDWKRqfbo1bmV6wVVtHgEFmMabeJ1Fi+6nv5VnBpHHaqAM2jFRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=U+gaTE2rxn1GavMY3VnMCM5lJuO+puyH/nRlKYyd314=;
	b=i0oxjSLUZZaYK2XCc53lOcsHg5W8CpWdXsKxzqiEWSekP9447+5A2uYaZvgjcL6N+knO
	 VKnxoC/MHGnHgL9wkhic0GjaMCdmBCCMVBXZJMcA6CYVriAL4+pfAIkYtVCF6OfuiYYd+
	 stYMQH6rcAGyWGhIdQ3G8l70tjkWe0nYItfYtpe85jCZkbd6361WQecSdJX9nrwrZjfGB
	 Rk1c1jfSncg0VSJhbaMLPXT+uMHsd5ZAl4vza7gH16mrp9VejHcy33BA6DoJwhGgU6qjp
	 uW3jN9HuNBmIMXxLDhWuLeJxLwLH00TZw6TfP7uuTwjTgVfZA3ptynFpp5Drophaihg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V6jBQUi3;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2C606A32C
	for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 23:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49B2C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=V6jBQUi3
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2efc4a84e75so11335ad.1
        for <kvm@vger.kernel.org>; Tue, 17 Nov 2026 15:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794958272; x=1795563072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U+gaTE2rxn1GavMY3VnMCM5lJuO+puyH/nRlKYyd314=;
        b=V6jBQUi3q6m1fugKTg8i7lQ8YDvbRwD84RiZEIDWlYbSi4jmx0O8pDk4TcWjUIoq2Z
         gSlmayGUYvbM38basu2SKO51QKrDucxN/t9XcIBZVCnrubwuwJMauuOP8Mb9HOTMtvyJ
         LXgTh/Z1zeODT20b0JPvKIWGItpbuT3dcTIFML5bwiUjxAE0ThCDfG72VkGLc5mdKA9n
         kXUzRcqWRx2W66sm+0xf0rpa0PCEUmT6iLs6R5AYw/3GnzlZHsUdBbBFXkhe7y9bECxf
         Rz1bS8cDPMArbZZ9L11+LBukFRCW3fGEehtJQLVAfF7FWZHWpRSx3RiaBHZcMMkYoeUJ
         KeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794958272; x=1795563072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+gaTE2rxn1GavMY3VnMCM5lJuO+puyH/nRlKYyd314=;
        b=rEUWW51WnnqFeUZ6QXugtUmLH3El1ruqIJskaxJfqM9osaDz4uLoRBxeXYCOt6L9Is
         1Mj8RKHo4M0B9LWell+6pj8rVWJJ+QLgp5cySdM0uVHyvngHFdrpouE0ykyfgneUZWHP
         xMfm7vSlOhNVw6mQF10K38mJrP2zpLTkTcGJWaTFFqxtWqzSOIsjVqT0lmYEQylQmvRD
         UmOp2AfmFNhx13wd4Ex5wxh4KjNAkVNvNnJTTgzKDKjGoUkD8+UGa4R3Hc8kXkpEc9FK
         1lNsZ0YVKdqIkqoWF5PjVh6Jw4WjaV8JyssQmtCHl7uFenop+PXvj48eQAbNzHNzOWx1
         yzcw==
X-Forwarded-Encrypted: i=1; AL+hErH5+OCJ4red11D9BQlSD21ASKOLxLMUI2jxYLvG/UI55yY/pN6brx02ZZOz58jSepQA1cg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HXPf7IIdymWrpWo5Wsovoun3VR+Fkb6HWZCRE3V9G7VnJT/g6
	XPY70zy3T3mBkBYF0C9tsOdP4XfXwtq5TQu0D2ce3IILlFjw/gPHLIP92lmgbcom5g==
X-Gm-Gg: AZFdTZdJ1ddWQ4z6InLCRlW3y2FPOkBCLICTN5u4pK0j0GcW/ZTdsU8/wfbN8BwfPbI
	boLfjIGVpWc+JDiKCRO4WjURQrIPm0vAbMMXQoLnjrJ+bg6N6GLxNL/8xvxhpzgRDKHQWJbwolm
	SoKNPxSR1nxd+YRSgD3lCI9a3XYpgU+gG09/0EstqdaxrvgtT2jenG8At5xrffPBDYwSrs7WRSy
	fi2Px/vvvt+3QFSbroIk3vOPAZWqMQmiS65zeV+8ygJsWD19Bf076C02tHB3BVC4eaupl+e5IgY
	pv9An/jEF9fOK4YqFUYAREJrpBIeapXbSyYDPGAV1T/aBQCwZerwLZhqJ2+W0syZG1LvmnSsItE
	KBytfE9C+y8PiA1ghdjmRDvooF7aI4888AkhfRHu6jTrOPLq6n3RWxKbK/yxiF6Sx4rZWWTHsfA
	w7P/cgMAR546uFzxLHSID7SMMgaewhaD3PnHSun8e8YLXvY22nigKINnvJ66M84GJ+hKYEzfvOL
	Xiiaq5d4PLC/xiqbLVaTG+V4tPqzwu23yDzQLS8efQnhZyCZqKE3hP2bqL7Ts8Fwv0oVHizIH0T
	FLXI/zOPqTY3adLvrpwm9C7ammCPeTSaCOs5pVsA991DFAJKXqZYT1NTmrUaSg3yM6YNX9Af1kF
	s0Qp0gOxnijUxwM2OBgW6vA==
X-Received: by 2002:a17:903:2cf:b0:2ef:d87f:8a20 with SMTP id d9443c01a7336-2eff9910e43mr1188255ad.12.1794958271877;
        Tue, 17 Nov 2026 15:31:11 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff5ed0998sm3827275ad.4.2026.11.17.15.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 15:31:10 -0800 (PST)
Date: Tue, 17 Nov 2026 23:31:08 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: Alex Williamson <alex.williamson@nvidia.com>, 
	kvm <kvm@vger.kernel.org>, Alex Williamson <alex@shazbot.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-pci <linux-pci@vger.kernel.org>, praan@google.com
Subject: Re: [RFC PATCH 0/5] PCI/vfio-pci: Guard resets against active SR-IOV
 VFs
Message-ID: <avzfBjBZiOnJUH4W@google.com>
References: <20260812045325.2733631-1-alex.williamson@nvidia.com>
 <an0BOyexLcOjFJw9@google.com>
 <20261117225559.GB2250529.vipinsh@google.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261117225559.GB2250529.vipinsh@google.com>

On Tue, Nov 17, 2026 at 03:02:00PM -0800, Vipin Sharma wrote:
>On Thu, Aug 13, 2026 at 10:30:45PM +0000, Samiullah Khawaja wrote:
>> On Tue, Aug 11, 2026 at 10:53:18PM -0600, Alex Williamson wrote:
>> > It's recently been found[1] that vfio-pci doesn't restrict resets on PFs
>> > while SR-IOV is enabled.  This can not only result in an uncoordinated
>> > disruption of the use of the associated VFs, but the ongoing use of and
>> > access to the VF has the potential to result in machine checks.
>> >
>> > This series proposes that this gap is largely an oversight of
>> > pci_reset_function() to recognize that a PF reset affecting SR-IOV VFs
>> > violates the scope boundary of the pci_reset_function() API.
>>
>> Hi Alex,
>>
>> Thanks for sending out the RFC to fix this issue. I cherry-picked it
>> into my environment to verify that whether it fixes the issue I was
>> experiencing and it does fix it. I will continue to do more testing, but
>> when you send this as a formal v1, you can add:
>>
>> Tested-by: Samiullah Khawaja <skhawaja@google.com>
>> Reported-by: Samiullah Khawaja <skhawaja@google.com>
>>
>
>Hi Alex,
>
>Is this series still on your radar for formal v1?
>
>If this is the direction we are going in I can use it for liveupdate work
>  https://lore.kernel.org/all/auzftbPFO_6XBYVw%40google.com/
>
>Thanks
>Vipin

Hi Vipin,

Alex asked me whether I or someone on our team could pick up this
series. Pranjal is working on it and will send out a new version. There
is some extra work needed on the IOMMU side to make sure that the device
is moved to a blocking domain when the reset is skipped.

But I think the patch you need is fairly independent and can be sent out
separately from this series:
https://lore.kernel.org/kvm/20260812045325.2733631-6-alex.williamson@nvidia.com/

Thanks,
Sami
