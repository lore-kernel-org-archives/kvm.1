Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34CD253958
	for <kvm@vger.kernel.org>; Mon, 23 Mar 2026 15:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278169; cv=none; b=HxeXgIgt2AcORW//YL2vqTyu2BIdCNI+ry3q7oqJikJRTJEfqrcw8GxdMXQfPIN3Uh0eV9Zn7V89BHA1Cu3ckGkxK+bbKUv/gl+J2ch7Y2YzeQLF9m97VJvjoSTBhdcKi4hDDsJwy1LZCSIPp1bvVzTh9X9UsuXG+NJ3DN43rkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278169; c=relaxed/simple;
	bh=1wITn7JaX1m/FulqoouepXzg40hLl+PsPdDqCmZOZRo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NKW9k/3Wjzk3QrMs1OjW/V8MIrIXnRTnZS7xrKZSABmaxtyMIXJSRMGpw1GXw8DDozXfXGHD5/4CNm9l9ubGBWGnh4KwbzadB8TbFOvOu747LZYpMGBLa8WabYOyX+MAeRnOP8fyjb+sEuKjTwHYugox5aAcJ4t9DDUAYPi4YPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4188314BF;
	Mon, 23 Mar 2026 08:02:41 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD3C53F73B;
	Mon, 23 Mar 2026 08:02:42 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: will@kernel.org,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	oupton@kernel.org,
	jean-philippe@linaro.org,
	andre.przywara@arm.com,
	suzuki.poulose@arm.com,
	kvm@vger.kernel.org
Subject: [PATCH kvmtool 0/6] x86 compilation fixes and arm64 PMU improvements
Date: Mon, 23 Mar 2026 15:02:15 +0000
Message-ID: <20260323150221.49256-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first two patches fix the following compilation errors on x86 when
using gcc 15.2.1:

disk/core.c: In function ‘disk_img_name_parser’:
disk/core.c:27:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   27 |                 sep = strstr(arg, ":");
      |                     ^
disk/core.c:39:21: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
   39 |                 sep = strstr(cur, ",");
      |                     ^
virtio/9p.c: In function ‘virtio_9p_rootdir_parser’:
virtio/9p.c:1503:18: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
 1503 |         tag_name = strstr(arg, ",");
      |                  ^

I couldn't reproduce the errors on arm64 using aarch64-linux-gnu-gcc 15.1.0
and 14.2.0. I tried doing make with V=1 and it looked to me like kvmtool
uses the same flags on x86 as on arm64, so I assumed it's because of the
difference in compilers and I didn't dig further.

The remaining of the patches are there to improve PMU initialisation and
error reporting.

Alexandru Elisei (6):
  virtio: Do not modify const strings in virtio_9p_rootdir_parser()
  disk/core: Do not modify const strings in disk_img_name_parser()
  arm64: Initialise the PMU last
  util: Set exit status to errno in die_perror()
  util: Allow die_perror() to take a variable list of argument
  arm64: Improve KVM_ARM_VCPU_PMU_V3_CTRL diagnostics

 arm64/pmu.c              | 60 ++++++++++++++++++++++++++++------------
 disk/core.c              | 44 +++++++++++++++++++----------
 include/kvm/disk-image.h |  6 ++--
 include/kvm/util-init.h  |  6 ++--
 include/kvm/util.h       |  2 +-
 util/util.c              | 21 ++++++++++++--
 virtio/9p.c              | 21 +++++++++-----
 7 files changed, 113 insertions(+), 47 deletions(-)


base-commit: eb915c763e4b95dd4a9d32763fd449459742e053
-- 
2.53.0

