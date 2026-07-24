Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF2466B7C
	for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 21:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784929327; cv=none; b=a5ftVurVdhE5cLAvnPu3Dy7YrC60EDsvvPlMB+N9i9BmCFqpwg6rJiVKIsbYtuln5RGEQ43PBr28GvFGFDIm0dGreCPrftVul1WeriQNYZhPrCS83/NcI3W3cjnA9OA808W1F3Rh9ctvkP/3Uon+Yx5y9Q1UreiGltmCENz6E5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784929327; c=relaxed/simple;
	bh=yK+v65dl8Oh8uBTbkQmHDaAB5BEVO8HHtvGN1jZbaD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NV1FO4jXRI3j5oRt1k54AONrtfQ1NzOF63UM7myXWtM8xAo8pqTfv975mWEv2sQdqtqBhsPyuIeeWXYvS9Itm3hXVEZHnhCg4SWn5l551TaHonluPBuIjcGJhR2HLmXkuvXyKlKA4Hw3ojGXWxNJf3Auy+ZQaDXmoePZf837eh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QIBT3HMY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QIBT3HMY"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cea3004256so11457695ad.0
        for <kvm@vger.kernel.org>; Fri, 24 Jul 2026 14:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784929325; x=1785534125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tXCbJonP5RTpEDTMHQcyo1IXdRFWvNUzhtlZCMlOUEo=;
        b=QIBT3HMYkZq7pp+I+fKoOJjBzHciOhjFrdS+vbK3cWUL44uStiF2Qhmx5Ro/u6VObS
         Lov+froDq8UeRkfIbvy/ODFpShsLpVnP+lP+Qs5WT76g2ofKLjtQsj2bpTdxipO+AStx
         dGQGMBYOHOBL7QIv1+FMRr+9cf7hPde/qcf8yqLqQcqQ3etJO6Eu16udOByJD588eVv1
         mxI6S6ABF1x2cApnSkxun6yK0Mt4sOCjwtW6mQg0/djV9cvZdRWoDgp0GjxCzCo6NOZv
         PmkVDj7q3XBx26L8vYVn616BBoIU1FWTbsa1pfTUyIl6N0pKINC4gAIpEvvHJIbQU0bb
         IQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784929325; x=1785534125;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tXCbJonP5RTpEDTMHQcyo1IXdRFWvNUzhtlZCMlOUEo=;
        b=pySvYYfWX68LdQy7KSyAdXF05PVygdg68yn5s+Brjr1sn6X4kaGpn1rI5LHmQhSzmc
         nx3Ro+5LGsKNVH+N2rI5owka3s04g1FKGD9jmxce4oJMwbJgpuSzDIOGQUUM3exUAwTI
         mTK9OkfH31UgARREjL9Ali8S12hFW6PMkTAH+Iu1i6lWX60gRxMe9o6DKCxvjztPtT+l
         66J2PebmtDKlmkNzqucY79OsgKlFQJp6R6XRuCCJHKZRsNoeWqRhqS2FayO46XNmaim2
         wMmQu9d6PDeHZfhPZ3+2aGdKXy5+V4K2t20BIL8Swy73NP3CMnRzoYzDYcsX+8U7rC7D
         SRkQ==
X-Forwarded-Encrypted: i=1; AHgh+RpmlB1y+wTHY1TO2erookZ+gSECHuCBOkj7b0BYcWUMV3ePo1n8J7+bs3lRNkbiurnosmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw51yjdD8/l4BUXZL1JCQJKFydlJMAXvz62jYDc81TgxTZ1mPhl
	Rq/zMwVgvpCq0RkgH0ehEsMaNdhO5QiKRwpDwpUFo8q/3GdW2bhh6RaLSUxVSbHK9w==
X-Gm-Gg: AR+sD12hXOC3fp3ZWznWC6TTpK8XfEewLF0JOeizO59Wcq0wt9/FU+pwb2YC7KOcAjQ
	/XCOHRSDMc8n6X7Q0Lo0yyYsbi1NQQNr4rka87TkxgyAqkJVauyzaIrgz2fJAdZFvpKyPrQPmo1
	kpGEsOi0QeLx5R3/arYzH/0KR1wfcespCyDENvSie1aQG4u8KzKz3wiASXd9g26xwcZTVSOvc6u
	EAJBLS0ZQbtMk76mYQSdwUmeR0RyVW1iJj50k2ezuuZAlZS3VUsbRgloiWVYbHXa7HLEQwhRdqW
	jvXdfP+YRnLsfUE20dsQg+57Y1yw+WWJp9hdR7RTZ5IOqtYu0o/SvR5O/Ata8F4lJSHf3+9ZiaL
	NdJahz1F8pjoBPVjtfehEiiirY6SslncnxHsWZZuUZAIcGDf7lulimNhbt20wtENeN8HnFR9vUf
	tEik0ZvBXOpF5L7NiYUCyEiGXYzt3GQWEd/gPS751x
X-Received: by 2002:a17:903:3d06:b0:2c9:c18f:7446 with SMTP id d9443c01a7336-2cfde8473b0mr1424615ad.27.1784929324250;
        Fri, 24 Jul 2026 14:42:04 -0700 (PDT)
Received: from google.com (79.217.168.34.bc.googleusercontent.com. [34.168.217.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bb35sm607925ad.12.2026.07.24.14.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:42:03 -0700 (PDT)
Date: Fri, 24 Jul 2026 21:42:00 +0000
From: David Matlack <dmatlack@google.com>
To: Josh Hilke <jrhilke@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>,
	Alex Williamson <alex.williamson@nvidia.com>
Subject: Re: [PATCH v6 0/6] vfio: selftests: Add driver for Intel Ethernet
 Gigabit Controller (IGB)
Message-ID: <amPcKEBsrkTH1JqQ@google.com>
References: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260722-igb_v3_b4-v6-0-0be1d29918d4@google.com>

On 2026-07-22 12:15 AM, Josh Hilke wrote:
> This v6 of a series which adds a VFIO selftest driver for the Intel
> Gigabit Ethernet controller (IGB), specifically targeting the 82576
> device. IGB is fully virtualized in QEMU, making it suitable for running
> VFIO selftests without specialized hardware.

> Testing
> =======
> - VFIO selftests builds clean at every commit
> - vfio_pci_driver_test passes using IGB driver + QEMU. Use the following
>   command to run the tests:
> 
>   vng \
>   --run arch/x86/boot/bzImage \
>   --user root \
>   --disable-microvm \
>   --memory 32G \
>   --cpus 8 \
>   --qemu-opts="-M q35,accel=kvm,kernel-irqchip=split" \
>   --qemu-opts="-device intel-iommu,intremap=on,caching-mode=on,device-iotlb=on" \
>   --qemu-opts="-netdev user,id=net0 -device igb,netdev=net0,addr=09.0" \
>   --append "console=ttyS0 earlyprintk=ttyS0 intel_iommu=on iommu=pt" \
>   --exec "modprobe vfio-pci && \
>           ./tools/testing/selftests/vfio/scripts/setup.sh 0000:00:09.0 && \
>           ./tools/testing/selftests/vfio/scripts/run.sh ./tools/testing/selftests/vfio/vfio_pci_driver_test"

Extending this, you can run all VFIO selftests like this:

make -C tools/testing/selftests TARGETS=vfio install
vng \
	...
	--append="hugepagesz=2M hugepages=1 hugepagesz=1G hugepages=1" \
	--exec "
		tools/testing/selftests/vfio/scripts/setup.sh 0000:00:09.0 &&
		export VFIO_SELFTESTS_BDF=0000:00:09.0 &&
		cd tools/testing/selftests/kselftest_install &&
		./run_kselftest.sh -o 360 -c vfio
	"

The --append flag makes sure there are HugeTLB pages allocated for
vfio_dma_mapping_test. The "-o 360" is needed because
vfio_pci_driver_test takes more than 45 seconds.

> Alex Williamson (4):
>       vfio: selftests: igb: Use PHY internal loopback on 82576
>       vfio: selftests: Add helpers to re-enable interrupts
>       vfio: selftests: igb: Factor hardware programming into igb_hw_init()
>       vfio: selftests: igb: Recover after DMA-read faults
> 
> Josh Hilke (2):
>       vfio: selftests: igb: Add driver for Intel 82576 device
>       vfio: selftests: Retry on EAGAIN during device reset

Reviewed-by: David Matlack <dmatlack@google.com>

Thanks!
