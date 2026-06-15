Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B973A783D;
	Mon, 15 Jun 2026 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552735; cv=none; b=n6lUQRXN7MVPgVUwKR3Le62lUWAm9gwdVSiRhvSczzN2g5h/o177k48ZyizFPrqtZZQcsrZ8a4inSxR5hDgW8p0DFOuLZqTx1r9Oi6zIbzFTI+5T9kIisJZVbtz33IcN59uVTGNI0b2fxze6UMcyPIF/RQ+SdgQEm1TvJ7RNTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552735; c=relaxed/simple;
	bh=FDHf7U4X55reFqVUhfhhoBmGKF3N0D8S+rd2ezxiNKg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=jj86pveIFH8IpWHz3d7+ZDyyoR2hZtMkiE7uxdOF59ijfmKLM/Zdpnmihu15WbSMIMLdpPzks1+N7U83VfJJJtdQJEuoBNkkMVeM/etjUbiOFJ6XozjzVpQ5Omr3468ZErqeFOCyktzHk9YhfmmtTWUhHsXGE0Y3+MoZyY8fPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=S0HuVtXD; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="S0HuVtXD"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FIwEJ32969350;
	Mon, 15 Jun 2026 12:45:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=5OK8nAMoINAkcKNytQ
	hxl9ERv7t4F+5ekKo/R203pZc=; b=S0HuVtXDox86Bj4nvVXFxPYjdvekHaoIyR
	lOyiTB1edn0wksYvEMuyScyXsbx9vNPEaVM8ILqrrSCpH2qsbRT52nTjmS/kdN+z
	Hs1zE0+z3T40Y8cSoeVVDlhTi6b8ofykfzAsvPZlmlo3ANhMZgEmCYZfkCaNZfVO
	Epo7Rm3pTRYC9GUiwgIYsLBqHK9eOJ5n0NiUJN4BB9llbYi85PNJrzTTDaGp5ntW
	B28dJuyYk5eW9SLjN7Kxi8v4wc31qO3XQcqIMFuDew9ky8a/Kf2UyWgLvCcHJIFg
	QdPuWor3w7Ynph5Jk/EdJXtGO92ghi3oTPp+7QtbKHllumMsGK5A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4es4a6ketk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jun 2026 12:45:25 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Mon, 15 Jun 2026 19:45:22 +0000
From: Alex Mastro <amastro@fb.com>
Subject: [PATCH v3 0/2] vfio: selftests: Add calloc_assert() and avoid VLAs
Date: Mon, 15 Jun 2026 12:44:50 -0700
Message-ID: <20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-0-b3798415c72a@fb.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADJWMGoC/52OQW7CMBBFr2LNmqliO4marLgHYjF2xo2rgJHHW
 CCUu1ehi7Klyy89vfcfIJwjC4zqAZlrlJjOMCq7U+BnOn8xxglGBaYxfdNrg+IzFT8jnUhKTlh
 DTCi8hMJSBKmmOGFdSNAOHTs7eWfJwU7BJXOIt2frcPzdcnXf7MsW2Ig5Skn5/jxT9cb9p1s1a
 nRkybvedqGhfXAfPp1gi1bzqu3e0RrU2HI7hbY3Q/P5p13X9Qc0niYCSAEAAA==
X-Change-ID: 20260612-scratch-amastro-vfio-selftests-avoid-vlas-395eb3dcb3ab
To: Alex Williamson <alex@shazbot.org>, David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Vipin Sharma <vipinsh@google.com>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        "Alex
 Mastro" <amastro@fb.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=V5dNF+ni c=1 sm=1 tr=0 ts=6a305655 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=03ozwUkBphtHgyqjj1sw:22 a=bC-a23v3AAAA:8
 a=FOH2dFAWAAAA:8 a=-R2Yz_5xwDJVClEb3P0A:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX82tHIkm6SdNU
 KITes8P7pcliO5X+zOnKbSHP31T1EvTM5zRb72gTbDndkiHVB2coHlcqehYU3ft0bMg5gj1pXxK
 SdkQKpfcK2vtxydjQymrsAuSOzkg5VMiu6ucC6RntQ4XaagT5ISzqQfWLMzLnUMVEKBBOM3/UPW
 R52kgbFQYrbqRSdMuZ5zCu9FMLBp+pYPpdrKNR2DYXvrWtIhFVEvE7dZe6P+kLc+O69C6r/1a8n
 0utnzPOiU87a04lMdoqVTwA081Ypq6FKNMYtqqJCyMYLqPYMumgvZ5Jt8wvn2OALT4IQPQ2eioD
 gOuQvnw7PTWgfgEXofKqalpyhUsisllikSFh53XruB1JUbSApI2A8+OBjju+koLgt5TRb0939Qo
 x1hntEQfpLzcMjpXBgRLK7xTJmx/Z9k9UQ9cLRWQDT9JJlvRlSnHkoEZs0xgs3Jp+o6Ww0f6w8I
 XqxD/ZlBfbkKqUPXJEw==
X-Proofpoint-ORIG-GUID: FHcJVT5AfOZN2xUXyXjUsrJ6Fcuck-1d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX7DiqU0pBhypx
 11p+Y1HdGD99Dv5B5ph8zOlK7sE/4vao+NkUCRu8CHA7MEBR6i7/TkBTSXNWfPnL8YkFME+F7Y+
 q8JwHPAZ4jplMKmUqAFMfbVVl9KoV2Y=
X-Proofpoint-GUID: FHcJVT5AfOZN2xUXyXjUsrJ6Fcuck-1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01

Add a VFIO selftest calloc_assert() helper, then use it in places that
open-code calloc() or malloc() followed by VFIO_ASSERT_NOT_NULL().

Use that helper to replace initialized variable-length stack buffers in
vfio_pci_device.c with heap allocations. This avoids GCC rejecting
initialized VLAs and avoids treating a u8 buffer as a possibly
under-aligned VFIO request struct.

Changes in v3:
- Add the calloc_assert() helper as a precursor patch.
- Convert existing VFIO selftest calloc() assertion sites.
- Update the VLA fix to use calloc_assert().
- Link to v2: https://patch.msgid.link/20260615-scratch-amastro-vfio-selftests-avoid-vlas-v2-1-4e4df462908a@fb.com

Changes in v2:
- Reverse xmas tree variable ordering
- Link to v1: https://patch.msgid.link/20260612-scratch-amastro-vfio-selftests-avoid-vlas-v1-1-ba3acb635f0a@fb.com

Signed-off-by: Alex Mastro <amastro@fb.com>
---
Alex Mastro (2):
      vfio: selftests: Add calloc_assert() helper
      vfio: selftests: Avoid VLAs

 .../selftests/vfio/lib/include/libvfio/assert.h    | 10 +++++++
 tools/testing/selftests/vfio/lib/iommu.c           | 12 +++-----
 tools/testing/selftests/vfio/lib/iova_allocator.c  |  4 +--
 tools/testing/selftests/vfio/lib/sysfs.c           |  3 +-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 32 ++++++++++++----------
 .../vfio/vfio_pci_device_init_perf_test.c          |  4 +--
 6 files changed, 35 insertions(+), 30 deletions(-)
---
base-commit: a26b499b757cfc8bbff1088bb1b844639e250893
change-id: 20260612-scratch-amastro-vfio-selftests-avoid-vlas-395eb3dcb3ab

Best regards,
--  
Alex Mastro <amastro@fb.com>

