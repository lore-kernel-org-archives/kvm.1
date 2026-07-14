Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636153A453A
	for <kvm@vger.kernel.org>; Tue, 14 Jul 2026 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043462; cv=none; b=BmfD1zhQE+U7RWSGox/BgIzhEL3NKVUzuR70jkT5wqLqTYwXiciTB6iQJYR9c9PpNH03VO5RIASq1p4W6Vn4mvOBpwGfpTZR9bn93OkSJm2DQg4LfoUow9hhAlMHoZcsi/w3uD9KCBYZn1wvS/YXkEjewhvAsUn4OkL+5VMvFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043462; c=relaxed/simple;
	bh=c+Hw2IiP5ExG32wlR9k/CJag6vBghXguzIym9l/3lb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QEtu43SB1rKhKDYYhR0QFum2MSYENwOJG2U6N/c6gLZxLGES8n8LX8twGyijyyIDMj1pK7Ju+C6ki5b0SRXM2SD6dYTSer8agJCjB9csUKNJcEtO4aDlnmKKg9q282inW8UdNT83SGBimtW92ap08pPYz6xvQyR6RM/88g8nvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaSEPhQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaSEPhQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA041F000E9;
	Tue, 14 Jul 2026 15:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784043461;
	bh=c+Hw2IiP5ExG32wlR9k/CJag6vBghXguzIym9l/3lb0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RaSEPhQ3llm6pqhBRKj8wkzBtJ83TUZd1I7yFYgfnw3vjevTR3YHeZ300ZL6D67O0
	 QI9rmOsPNi686DDH8uG3S9cuyE1JVmnyFnpyvrXQYgSqv400KNdI2Dod+6Se7ngQ2t
	 Lh8yDDRuJ2wCnt1BbDEqplTDk6MiG2ATUtgMQUBOjz0a+exO62pUUMSzGZvB8PUu8G
	 D3UmBJQHyzphjZaniWnGF+vzn15fXq++fWuzI6mvq7ao+eob336vdiSV54E8vdPYjD
	 U3EQDPYgFFXEIfTNw42ehOsSg2ZB1Gythr1FEGDdFVe33H9fWAWgYE1fzK58NAUMxD
	 Bmg0ZkmG0fkTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 20/20] vfio: selftests: Add continuous DMA to
 vfio_pci_liveupdate_kexec_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vipin Sharma" <vipinsh@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260714151505.3466855-21-vipinsh@google.com>
References: <20260714151505.3466855-1-vipinsh@google.com>
 <20260714151505.3466855-21-vipinsh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 15:37:40 +0000
Message-Id: <20260714153740.CBA041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Partial initialization of DMA buffers in dma_memcpy_start().
--

--- Patch [20]: [PATCH v5 20/20] vfio: selftests: Add continuous DMA to vfi=
o_pci_liveupdate_kexec_test ---
Note: Due to system recitation restrictions, this report does not use the s=
tandard inline diff quoting format. The findings are instead summarized bel=
ow without quoting the original patch code.

commit 123ec8cfeb386e8660107c771eabe7ddc5cba029
Author: David Matlack <dmatlack@google.com>

vfio: selftests: Add continuous DMA to vfio_pci_liveupdate_kexec_test

This commit adds a long-running DMA memcpy operation to the VFIO PCI live
update kexec test. It ensures that active device DMAs during a live update =
do
not cause system instability, even though the DMAs are currently expected to
be dropped.

[Severity: Medium]
In tools/testing/selftests/vfio/vfio_pci_liveupdate_kexec_test.c, looking at
the dma_memcpy_start() function, the buffer initialization seems incomplete.

The code calculates the transfer size and sets the destination pointer, but
then calls memset() on the source and destination buffers using 'size / 2'
instead of 'size'. Immediately after, vfio_pci_driver_memcpy_start() is
kicked off using the full 'size'.

Does this code unintentionally leave the second half of the DMA buffers
uninitialized? While the test does not currently verify the transferred data
since iommufd preservation is unsupported, will this partial initialization
cause false positives or negatives once the test is expanded to validate the
completed DMA operations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714151505.3466=
855-1-vipinsh@google.com?part=3D20
