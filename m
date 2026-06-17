Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE95348463;
	Wed, 17 Jun 2026 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722705; cv=none; b=U8BNepiWXcI/1UczpWjocbSmF6/0yjWvwTSwesWFLxVQhkRtjcERhomNZsbuq5cbkK3U75EFfbMlgjd0dkQ/xbKbfbntGhPSlGEuG5rj8D1SEnOqmqX99tnjI3LkC2DK6wJryaEuGdtsHJB6atWHQ10axPZwtrFZWE93er60B44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722705; c=relaxed/simple;
	bh=4ZsQfuvRxxFiLWaj113imCWDpomyCVZyHIzvvVyraBM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=G4TByUrLRSEYxS8n2EX2WzDD/Gosqg2dM87tBMw3juDpJbPHv8myfMM9IClfGZ3mdzjAslACLtCYKv1fUvnxOOPwU8XSGFQTQY2F5/eMqBsJtl7rPGhlkFlioPUl67ekCR1tbDMqy2BKPzynzvt/4F0rN4QOUHn8M2/uHw7yzAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=a7Vd2IY5; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="a7Vd2IY5"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65HHdjsZ415555;
	Wed, 17 Jun 2026 11:58:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=GeS5k6oBH0Vk9oTzKz
	Q65YCeXY5f9yNPMqlAKF9rdWo=; b=a7Vd2IY5WWSgmXL2W0WjWrrlGcM0hWC2ZI
	p13Y4UA57rzE/7loXRvTBsDnE90/8P4k3ffCpEQXmytqZMfrsSK97UkY6jMNE6bW
	V4Y0fx96KiWoJw622cE4R3eHYQDYJ1sul+i474TB1wdAi3KR1P4VSillQjVksVfP
	ziXmd/n8SSMl2FIe8Kqg62kwMmCOjcSkUpaqId3+u4S1Biw0CCK2HMcj9cuZD7Qa
	5dt5TN+JD7cxnoLAKHektmhHSkbxbK5cxQZdAqS+CG493CgnVTy084WRO1LwSIC+
	k1UCf/F/JVKiZrO4AOPYAbEypa8MX8Al5cPdFEypk+6eE9WsNjMw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4euegpxjs4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Jun 2026 11:58:14 -0700 (PDT)
Received: from devgpu015.cco6.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Wed, 17 Jun 2026 18:58:12 +0000
From: Alex Mastro <amastro@fb.com>
Subject: [PATCH v4 0/2] vfio: selftests: Add allocation assert helpers and
 avoid VLAs
Date: Wed, 17 Jun 2026 11:57:59 -0700
Message-ID: <20260617-scratch-amastro-vfio-selftests-avoid-vlas-v4-0-b9f52f1e2c5a@fb.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjuMmoC/53OTU7DMBCG4atEs+4g/yVtsuIeqIuxMyZGbY08x
 iqqcneUsgCWdDnSp+edGwiXxAJTd4PCLUnKF5g6t+sgLHR5ZUwzTB0YZQY1aIMSCtWwIJ1Jasn
 YYsoofIqVpQpSy2nGdiJBO/bs7Ry8JQ+7Dt4Lx3S9t16O37d8+DcOdQtsiyVJzeXz/kzT2+6Rb
 tOo0ZOl4AfbR0XP0T+FfIYt2sxvtv8Pa1CjYzdHN5hRHf6y9mHWokJv9+PB6T7szQ+7rusX97K
 fFp8BAAA=
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE4MyBTYWx0ZWRfX38kJuITbtxGQ
 6dOxavJ5zOGMT5XKc4ejB4HU8vfi25LGgsNEI7+NqKDK6Eor7z1Zb6sMFHr/nEbPHEZw/wx7Ea0
 HiPX1GnU40zF4H9iesNF5MenvRHtsNYtvt8cMx75gS3hJwYN6E8/2oGb+Zn2nNVHSlHhJ6FZJp+
 FwMraqcvFOdxFSfC4HwAdyGJ/1pG8QiDi063rdUX1o11ahHBTJxa3Njuu1+vGkKj+o4kam1yXRx
 IliBGIDQiksS7okL67pa2FQ1DwaYroAxMHEl4KF2N78wDp8yFRKNNUhdpMNYYYakm2IMYvHnpej
 VHX8NEzlhiS8eUGUk5m5pKtoGY6VpH020jl98tox3A+YUoF3+1AoVcqEjWpK3lzj03KvTqnc7SU
 aZ7BwVNBKtDKhPfIij5YJ+nNJknYhYkk14leElICQ6kQJv3WlgX94HS4lYnqKGTasguet4N0D95
 5qZk2IWnuvROcG1pXHQ==
X-Authority-Analysis: v=2.4 cv=d/zFDxjE c=1 sm=1 tr=0 ts=6a32ee46 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=_78whYxrdx1mplLwxq1U:22 a=bC-a23v3AAAA:8
 a=FOH2dFAWAAAA:8 a=2z69HJfiPb0DcaFSnigA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: e-PvYubP5i1NnbW8QHdFu-Q4WvoN5xMF
X-Proofpoint-GUID: e-PvYubP5i1NnbW8QHdFu-Q4WvoN5xMF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE4MyBTYWx0ZWRfX4XOLKLOiFNAb
 2MqAWxjJ03s2oRdore+ycsCMH+kmLKuj6wKWnTKpW3T8ZN6MWrVPD5U+pU7b8UvOaGue1Wc/J5s
 S270N4xdN/IV7X5/Fj2pWpwQeEE5HXE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01

Add VFIO selftest {malloc,calloc}_assert() helpers, then use
them in places that open-code malloc() or calloc() followed by
VFIO_ASSERT_NOT_NULL().

Use the helpers to replace VLAs with heap allocations. This avoids GCC
rejecting initialized VLAs and avoids treating a u8 buffer as a possibly
under-aligned VFIO request struct.

Changes in v4:
- Add malloc_assert().
- Link to v3: https://patch.msgid.link/20260615-scratch-amastro-vfio-selftests-avoid-vlas-v3-0-b3798415c72a@fb.com

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
      vfio: selftests: Add allocation assert helpers
      vfio: selftests: Avoid VLAs

 .../selftests/vfio/lib/include/libvfio/assert.h    | 18 ++++++++++++
 tools/testing/selftests/vfio/lib/iommu.c           | 12 +++-----
 tools/testing/selftests/vfio/lib/iova_allocator.c  |  4 +--
 tools/testing/selftests/vfio/lib/sysfs.c           |  3 +-
 tools/testing/selftests/vfio/lib/vfio_pci_device.c | 32 ++++++++++++----------
 .../vfio/vfio_pci_device_init_perf_test.c          |  4 +--
 6 files changed, 43 insertions(+), 30 deletions(-)
---
base-commit: a26b499b757cfc8bbff1088bb1b844639e250893
change-id: 20260612-scratch-amastro-vfio-selftests-avoid-vlas-395eb3dcb3ab

Best regards,
--  
Alex Mastro <amastro@fb.com>

