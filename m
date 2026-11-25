Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629548;
	b=vQ4dGO4pN0m8yVWBwgAW2xdeLE2RY7eODayjih/xm0QH+EljYSDHDj+29jKwi0giBf4r
	 Nz82j3yHXH4J5HM1bRL5gFrUaAxuu5feJdoQoFvwJcyy7yyKWw/f/2UQUyMywOcVWpiE3
	 Lrb3/Th8pd6fH0328/Ups1d2Lpc/K2KWsapannO6BUomriAbPXqvt/AhBNr5Ct4sZ5fwV
	 lMT/5jjXmf3s3kgrf19aKWzfJ8GP50TDVDAmnqpG75aST8k6KUqxUHJBNZBlMl7LxZVmr
	 VCUaCPXOVZu3dyWWABLWvqAHkUJzBs2VMBeu2YJE5hVkxAoWx9MlzxI9Gy2+f79VoJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=V3ql+trEST5GBe5icgHLs8egrkIrOnsTHov8GZtBedQ=;
	b=MBsC9oOZVwIL+gmZVRZbCffZ57XJzAwwuufc0sC3kDrs5xvKrdF9HrB6958Wq7KB3GpC
	 kHz+HK112Hl7nkFmUOYsCuud1H6VuySvVoQcYJzRnHIZpZwc1VGqKOLCVjEVjlinabFFZ
	 eUB8BzOMc8tJ0zdz7Biu8dSMo8aDaVcx4Fcu9+uPSQQ01mB4dtKHgpkblqYMYMwfABNhh
	 ZePq9wpNgFxEP+B5hiKMDPON/7Ho/vEaQfNkVwDlEPOIyMy7iHzoz7HhhCsLasM5qkKpE
	 hoEkjtoKnG4b/A8gyG66w+ug1LeW2NeIiomrSgY94F3/seg8tIXOPnfTiqrnHMvJPUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oT5p5Fx+;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5E2606A31E
	for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 17:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D5E2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oT5p5Fx+
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cdddc79a4afso2533820a12.1
        for <kvm@vger.kernel.org>; Wed, 25 Nov 2026 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795629548; x=1796234348; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V3ql+trEST5GBe5icgHLs8egrkIrOnsTHov8GZtBedQ=;
        b=oT5p5Fx++T4ed75RtobLIo1wtLMtV+LHgUa6zJCsI6AsAvAWbzTbQGIzyyvVUqvwqL
         2bCnshfZscfckv9/9Nnd8V8Y8iaH6XyFa31/Ur5wvDyKnwTR7auXXrCHnSC6x1LPBapQ
         eMkanzaE241TyVD93LyVjc3gSLwkssy6lDnerYVCkflCM4ffPmNb+r+Ezbt9+R54IpXR
         4SIc2sRTQyb/DGFTuf4b/DlU79BK66QeK7hfMVhgZqgbDUqBNkNqSW6SIkzOWXbYdT0c
         ekYkl0rxCRDF22VxgGXkbPw0XxL15Ms2nHdVlVadiGrwGcKPgHA1IYH8yVFAb1lvVms3
         QnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795629548; x=1796234348;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3ql+trEST5GBe5icgHLs8egrkIrOnsTHov8GZtBedQ=;
        b=d/RC3E3dWf5sNPFSRAf3jUcaGmJ1pL5KKEIfgD0x/hoZmrm6X07QVPZVN+KE7yp2VW
         24/+w2NqI2yEmnI7eNHlxM5T8WaqR/1O2gMw5SyyK520bfL2jJdQypw7U5YgYcaoj43p
         1RjQw8HfdLcX3yCtDcfL9gJBuz8c5CWv+oWMEb73aZRa6+Zb0WzqtyMfajCZQyvIfBaT
         R8yHNmZv3G0oHcqKhGCyAiEBrw1+TdPcrFXmcQInZLzLrSTExVIOtHUSvelwYkQf+011
         oHnGM0p+q96fvFNpQJXz4CYPl2Kz+AHDSgOi0szHJCdPRHzAh78/On33v1nNI7lrKgAd
         Po6Q==
X-Forwarded-Encrypted: i=1; AL+hErGuOviQlvhHFMfI2FtLJVBfb6IRvZwvh68A1WsA6LLqS573BYZJZUUzJLC7AXaoslvEHxA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hWR5B0ukrMykpa95TO2ZmcwBQRWBHlBr1f9ps84fgZgScw7T+
	YlRY3vIHiSehPOcwDfsFVzOUwOhIstvLfPIQnqvPvzBSd4/7NWvMJ9XmZGwI2gT9ig==
X-Gm-Gg: AZFdTZdEG3uOgSL7MaZvoyV98AAgIsl7KneAV9kIhCg+ifaqjzOKlcU1xCoTUhqbICJ
	dX1MxtktgelS+GFb+/l2a9BDAbxRxMIoxwimfPIYEQDrVVxjIwBnnCT4HVv7n+rJoPhxxan25+L
	/C5XuWbcrenXWsXoEwEBSgrBK8GXbeU1CbVJ2nHgagCPSIP7Dh9sCgI9N5Wm7oi6hGpBKetUudA
	+z2OUb+DvwYTpimGn4Qcg/89MsH3RxMUKqPSa9bIoyBHm5ZWCarQGawGTqRU5pqfB3p93fGXw57
	Y1aZo9U88OvLzAxZVqymm+SEfl7JpBD1xpuCgSKo88APqU4yMPLKQgtkz9f8nV8K8KKZv/H3G+K
	ldV3J0dEiWVhYWWIq93vyXKdwwoVYXC4aH9xZU+WwM2dTtyZBXkyC+QQpPjG97sjRMA0bIB/Ro/
	FCEgpXZtaHdbEEgqTMGZj/1tXeOIpmY0s1rT9ViVC8MP6hHf2q5axJTHeELU3zYe8BF+d+vtZLH
	h5GmS6UcjuTtbFBlx06fMvdW1P7tku0IwuM+ywLpJ1YMBxZ/k/wQY3pGXCJSqMSqm5om6uTCSIq
	5FNbpS7l9oevhwoX2bgbzJ9u9cg3kp8V4X6TCuG334CKkAbsiVrk7jhlbp31n4aI
X-Received: by 2002:a17:90a:e7d0:b0:3ab:5832:72af with SMTP id 98e67ed59e1d1-3b41c9cfc12mr15413655a91.32.1795629546987;
        Wed, 25 Nov 2026 09:59:06 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb2076sm29085960a91.2.2026.11.25.09.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 09:59:06 -0800 (PST)
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 09:59:05 -0800
Message-Id: <DN4HJTFG5WHY.1BIGOM7LNESZA@google.com>
Cc: <kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kselftest@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <ajayachandra@nvidia.com>, <alex@shazbot.org>, <amastro@fb.com>,
 <ankita@nvidia.com>, <apopple@nvidia.com>, <bhelgaas@google.com>,
 <chrisl@kernel.org>, <christian.koenig@amd.com>, <corbet@lwn.net>,
 <graf@amazon.com>, <jacob.pan@linux.microsoft.com>, <jgg@nvidia.com>,
 <jgg@ziepe.ca>, <jrhilke@google.com>, <julianr@linux.ibm.com>,
 <kees@kernel.org>, <kevin.tian@intel.com>, <leon@kernel.org>,
 <leonro@nvidia.com>, <lukas@wunner.de>, <mattev@meta.com>,
 <michal.winiarski@intel.com>, <parav@nvidia.com>,
 <pasha.tatashin@soleen.com>, <praan@google.com>, <pratyush@kernel.org>,
 <rananta@google.com>, <rdunlap@infradead.org>, <rientjes@google.com>,
 <rodrigo.vivi@intel.com>, <rppt@kernel.org>, <saeedm@nvidia.com>,
 <schnelle@linux.ibm.com>, <skhan@linuxfoundation.org>,
 <skhawaja@google.com>, <vivek.kasireddy@intel.com>, <witu@nvidia.com>,
 <yanjun.zhu@linux.dev>, <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 11/27] vfio/pci: Retrieve preserved device files
 after Live Update
From: "David Matlack" <dmatlack@google.com>
To: "Vipin Sharma" <vipinsh@google.com>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261102153656.1431701-1-vipinsh@google.com>
 <20261102153656.1431701-12-vipinsh@google.com>
 <DMZMRTXS7OSC.M79XF39ZVEWE@google.com>
 <20261125003759.GD3545683.vipinsh@google.com>
In-Reply-To: <20261125003759.GD3545683.vipinsh@google.com>

On Tue Nov 24, 2026 at 10:55 PM PST, Vipin Sharma wrote:
> On Thu, Nov 19, 2026 at 05:01:19PM -0800, David Matlack wrote:
>> This is a lot of complexity for one commit, and it's hard to review. I'd
>> like to start with the simplest approach and build from there: implement
>> can_finish() and have it return false until the device is fully
>> retrieved, i.e. retrieved and taken over by VFIO_DEVICE_BIND_IOMMUFD.
>> Then finish() only needs to free the incoming state and call
>> pci_liveupdate_finish().
>
> Closing session FD is not retriable. If it returns an error then
> userspace won't be able to retry. So, only option will remain to reboot
> the host.
>
> VFIO doesn't need to impose this restriction. We discussed in LPC to not
> block finish() as this call can only be tried one time in LU if
> session is leaked.

Right, if userspace closes the session before taking over all of its
devices, the session is leaked and the only way to recover is to reboot.
I'm ok with that in the first series. It only happens if userspace
misbehaves, and the device is left running with its memory still
preserved, so nothing gets corrupted.

I'm not opposed to improving finish() so that it handles devices that
weren't taken over and closing the session always succeeds. But that can
go in a follow-up series. It doesn't have to be in the first series, and
including it makes the first series larger, harder to review, and harder
to merge.

>> It also has a nice side effect: LUO calls can_finish() on every file in
>> a session before finishing any of them, so a memfd in the same session
>> that the device DMAs into can't be finished before the device has been
>> taken over.
>
> If userspace has two session, memfd in one and vfio in another, we will
> still have risk, where memfd is retrieved correctly and may be
> closed/released due to a process crash but VFIO device still acessing mem=
ory
> by continuing its DMA and potentially corrupting memory.

True, but resetting the device in finish() doesn't protect against that
either. The device is only reset when its own session is finished, which
can be after the memfd in the other session has been freed.

With iommufd (i.e. not noiommu), memfds mapped into a VFIO device must
be preserved in the same session, and iommufd enforces that
dependency [1]. noiommu is inherently unsafe in many ways, so I don't
think we need to worry about this one case there.

> I am still inclined to let finish proceed without blocking via
> can_finish(). I can try splitting patches.

Please go with can_finish() in this series, and send the finish()
improvements as a separate series on top. Splitting them into separate
patches within this series still leaves this series larger and harder to
review.

[1] https://lore.kernel.org/all/20261025021930.674647-16-skhawaja@google.co=
m/
