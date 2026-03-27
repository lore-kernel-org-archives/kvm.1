Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B261B411622
	for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636818; cv=none; b=F7AjaoU3Xhj2TFwSfUlORIybNjennDxLNUdI+FOmfS7mYzKjfN7jCqgKkoanXK51ypTtwaEFAg3U+XGZ29UHv7LnHxrFzbYuXL6YplMmfGYbD40kR+t7azOhVrThHp/pbn/krq4R8YBatp6M6N9T/0VaYinm+05uSCyc8BiY0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636818; c=relaxed/simple;
	bh=68/qiY0dXiAzVFpmtFhIqp6f2IQFnIyj0gIBzOCT9pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXmsHdrMEEyN308HWJiVNxewydE9D5OdpTtAvHLdZ0MhPlWC3RcvKsEl8IqmF7p8yQGAO25LzHji9Bj3a9QphRc05H+eQvGFiyPbh1AR8RpnZrbrZrkpre4TPM9oOeIldF9Dg4Ui34y3CeFCEstCRe5eS3qNn36UvgS9ftwf8eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Btz5NleF; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Btz5NleF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b0c12be0ecso14045ad.0
        for <kvm@vger.kernel.org>; Fri, 27 Mar 2026 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774636816; x=1775241616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IHrdY81PRz9ZLomdNE3Lco/cvsoDmUDbtnq/OEDTzA=;
        b=Btz5NleF7/XdxiULaspPQfMFrtqqDq9iI/Fk2UxMk03yvJOiHsQNVUeFrBbrGei8Mo
         0sGkmlfMyO9MQRyb36mRYsBcu5RDyv9kSt7cbzs/ZZmqtSsqS+fgIajVC5h4HJ05jY7n
         d6OLaNdRC3OCES1CQeSBkWVI7mJwFNIQzSTsuemMcrtWyvmBNiD6M0g2BmY1wuSxOUq8
         opbchC7mHmOLtyTKbu7Rqae7jL5Sflw+MsK1W+seZIWAMPeNk3a4nhAIuOWt+NcQ9p5E
         nhIQrXBC3aixWZ60gDeaR0IQMRqOpiwcIN9bp/+sA6qEWeBiJU9DNrEDC7j+wO/NwUsi
         COaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774636816; x=1775241616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IHrdY81PRz9ZLomdNE3Lco/cvsoDmUDbtnq/OEDTzA=;
        b=iIs57H8L0jljIWOR/j2PkDWN6MPazdOYkpjTS31Op+6p3yhq/U6GT0lt7h/MPA67I6
         nZ5fS1ILddArZcJ13jBpxR8h39ZCpKBVntEGMD6TKrXRbxPZDKYAq20/7Dj27wwn8m6c
         EIsSDzkITUAoFuDgBB1JZeaQ2mghhSw5Ko8//GF71Tlu2oZZNfkZWaLKFDsh67El59b0
         AZxm0LoP9GkaUlsu0+AuwKE8Eh1gh2nTmwf00oPItg4IBK/Q3mTGREcN7UlkYQTl6qK1
         WUV9UGODBBzgDxEpzvnQLjQ0PCR6IzmQ4XCSR9mcdUbRi0ABNrbwCgWFuTPU4ieY5ruA
         67gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOWg/hhNy7610nDsF/T3ou5tJ+heBZKSUz0i81cksm4V72voPF7QsVGVhTCKeI4Qa+IiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8tQZ31gyJFYybJeN+oCifa5IF0EcL9pa65bgVRvnC0MKHHE9o
	earp9PNFnQKHsgV0uo663dleDmdTirRHAr72B1kuQ16TaIHZV9LObrxplybAWqKV6A==
X-Gm-Gg: ATEYQzytJKe4VkLP+qZupVQnme0/xTO/VVDF0iLcuxL0Zufi1Yf0pvXN9jCQNas86Q8
	G0k9OESwUCqQmP6fgwrm1RH4kZGK9diormvPkysDoHr26fkl3lewlUsaCalGRLaNSkpdse/ryMn
	ka/f9wy59mg5o/kbeNURVVCRpVt0hRgphR6Y63z/NdZ5ru5fWqg0wumK9COOZyWJ9VODVJE5lvp
	XoK0SoXZlRdYcb3q304XCqoy3puJ8mSrKntU+CYsgul72M0oFDCVnmOgeV5kk7WGxb1t7i3l36j
	1qqyp9aeoii0nUwVszVH5HFx3n64YTHzksTAykMC6uIgVErWfDbL+jYkzVxA3UDxCR7lAGMKR/q
	i+V1rlRvFyYarJVfV4YcDUgLt/s1Tlxes6e7hrHjDgU3Aq/vfoUNuUHSxkHQgwKQ92GhzmvbR5g
	DNAhvOxEFW48yW/0vfeKAnJNQGAuP3oYcZHiG39SEWrSv2dK/Sm3nUJX6hm3lUZQ==
X-Received: by 2002:a17:902:e5c6:b0:2b0:5683:1cf with SMTP id d9443c01a7336-2b241e48c27mr315445ad.13.1774636815223;
        Fri, 27 Mar 2026 11:40:15 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d388e5esm6639001b3a.37.2026.03.27.11.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:40:14 -0700 (PDT)
Date: Fri, 27 Mar 2026 18:40:10 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 14/14] iommufd/selftest: Add test to verify iommufd
 preservation
Message-ID: <acbOSmcvNTP92CoP@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-15-skhawaja@google.com>
 <acROHN5KhJIef0Yd@google.com>
 <acbLdqSEjDNc5kWy@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acbLdqSEjDNc5kWy@google.com>

On Fri, Mar 27, 2026 at 06:25:36PM +0000, Samiullah Khawaja wrote:
>On Wed, Mar 25, 2026 at 09:05:32PM +0000, Pranjal Shrivastava wrote:
>>On Tue, Feb 03, 2026 at 10:09:48PM +0000, Samiullah Khawaja wrote:
>>>Test iommufd preservation by setting up an iommufd and vfio cdev and
>>>preserve it across live update. Test takes VFIO cdev path of a device
>>>bound to vfio-pci driver and binds it to an iommufd being preserved. It
>>>also preserves the vfio cdev so the iommufd state associated with it is
>>>also preserved.
>>>
>>>The restore path is tested by restoring the preserved vfio cdev only.
>>>Test tries to finish the session without restoring iommufd and confirms
>>>that it fails.
>>>
>>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>>Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>>>---
>>> tools/testing/selftests/iommu/Makefile        |  12 +
>>> .../selftests/iommu/iommufd_liveupdate.c      | 209 ++++++++++++++++++
>>> 2 files changed, 221 insertions(+)
>>> create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c
>>>
>>>+int main(int argc, char *argv[])
>>
>>The iommufd selftest directory heavily utilizes the standard kselftest
>>harness (TEST_F, EXPECT_EQ, ASSERT_EQ), by writing a raw main(), this
>>patch circumvents the standard test reporting structure (like returning 1
>>on argc < 2 instead of ksft_exit_skip(), and returning 0 at the end
>>instead of ksft_exit_pass() etc.). We should rewrite this cleanly
>>following the existing iommufd test infrastructure using TEST_F blocks.
>
>Agreed. Will do.

Thinking about this more, these liveupdate tests are two stage tests.
There is a run before liveupdate and there is a run after liveupdate. I
will have to use the luo_test mechanism here for this test. See example
usage in the kexec_test in the VFIO cdev preservation series:

https://lore.kernel.org/all/20260323235817.1960573-21-dmatlack@google.com
>>
>>>+{
>>>+	int iommufd, cdev_fd, memfd, luo, session, ret;
>>>+	const int token = 0x123456;
>>>+	const int cdev_token = 0x654321;
>>>+	const int hwpt_token = 0x789012;
>>>+	const int memfd_token = 0x890123;
>>
>>Shouldn't these be u64? Defining them as signed int-s undermines that
>>contract?
>
>Agreed. Will update.
>>
>>>+
>>>+	if (argc < 2) {
>>>+		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
>>>+		return 1;
>>>+	}
>>>+
>>>+	luo = luo_open_device();
>>>+	ksft_assert(luo > 0);
>>>+
>>>+	session = luo_retrieve_session(luo, "iommufd-test");
>>
>>[ ---- >8 ---- ]
>>
>>Thanks,
>>Praan
>
>Thanks,
>Sami
