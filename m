Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794531215;
	b=VAk1eHpSJvOXaLtbkZHAQtONKPxKkiw+6NoHoi6wYIMhDZvgf0iMeMbMpki3N7e7zKCa
	 LJ5RFdolDk21PVOw7NTExsK57VpAq8Ib2BE0bBxsYSGG70Jm68DctRH1yRlJyptEITWXe
	 QbwhAasxuSXv1WM0/EsJzZKWJWA6s8C+czlEZe8to914ZsxwsWJYST2vc5xNJxPAzWwBz
	 t3oGX0NzVMrQygALAILYux6LK0jdXGWwq2nG8HgFeyXVFWr2IRaE8u+jujyfQMG0dWqJY
	 2aFUMOlSq2QgpRrdpfSpvOX/GAU9/xlzrX6aVIPHwu9n5rsqt9OMtyG20qzLZGX3Jpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531215;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=TZ2I5JnqLLKymQjgfGOiu7gr6dxmqb2X30Vtl73Qezg=;
	b=jBSpOpf/YhsuBh7jBds9321GMk3fVbSCpBOsBSOGtudFrvkZTIXEy2Z8mr3fAlwCxDxL
	 lYv9Wxo7i63r7lRPWyPJAx7rOgD7grw8r/il7Y2B00nNRCclCz0rbbFIGcpW0g20VO/BC
	 5laL0fTzCXeZAGjlrXJCql3OD7FHj95Qm4qYxWIKyaqFmOhtVuGdvV23+jB0rdSzuXvx0
	 A9c1uIV5RZEBa+jGc/BCzG3PyxvjKNLZX0iN0ffyErVkY2D4mv8zZKdwmOMLPBqvw8xOD
	 L+Q6Ec/IgqsCrPdOkZp4rvgPhKye2XspYqiZ/OJ12tGCt4yTBlDMfK4o8a5N4C3kbgw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2fk84om;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BE2606A31C;
	Fri, 13 Nov 2026 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k2fk84om
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794531215;
	b=i1ypHyINAFlMF19BUCyfxKdUISPqTJVLHjYr4hRqWwHz/685pJu8tuk7q9q85iPBAPno
	 06+rLLqzipcSN1dMz3+QTCEvNEZ24MD24UmPT7JMG7hUcmEXYTkLNg1WQDT/Es/xIbiwh
	 0K5mFxIduzrGhYeLMfrtRLhjPelljIV7EwPvrOheMS5/aYfP0B4OZ9MSlypfrqXJNnS6L
	 GJi+A7xCt+GWYZ50/LXaIlyxYhCnCT7EOyAaRtnIci9LLcvGlXDir3RMUMawfAI7SY+uG
	 +m12/ZiQTjuVJjmFbM/RXMl6X/I9mcz+qWObHt+i4NL/9uqwNt9Xq/XHJqSzOlUyRCA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794531215;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=TZ2I5JnqLLKymQjgfGOiu7gr6dxmqb2X30Vtl73Qezg=;
	b=tjr7P8TI7EJ3ZvBcXIrAfTw3xUJcgQrQmMxxzwbndUmv0mLS1U3rHjp/l29yE2idRu2R
	 TxUvxP80rEaqWioWjOxBFGPjurFhCzt7xbw7jFQErsLmUmCpTz6i1eptHZNwWtx9Ns6Cm
	 J26vzfqIVzCGDg+hnYxorcAMJ49ltD4wGAc0bO2rj18tQijKEwg8+KP23+/aweKOBxQQi
	 CNbfRc/Z8h2gZb6C3ydMEO6gJDwSPlR52hQAc0sgjo/daLz5stZZ7onRRO1H1HZG98E+3
	 Kv16Jldngi2Rjz+9XIV68O960zcimjcK6n4A/PaScUQGczbeya9fYMzrsRFZOsS8aGw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8D5461F000C4;
	Fri, 13 Nov 2026 00:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531215;
	bh=TZ2I5JnqLLKymQjgfGOiu7gr6dxmqb2X30Vtl73Qezg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=k2fk84omGb+9fxXGdDJC37V90qpM9sf2rmA3nl1YeLY7TaNVxIZwJu5izng/ssAl+
	 2w6tvVShWxtdDGJrESgnPoDw7KDd4BqmA/RdzuLdhRQjWGvXTEz76OGIoSwyj4UoqO
	 iTxzYsits/07LY1p8fIE0/cVAPgFSs9p+xs9vQSJNJck71tbPxfBGwPKGr4XCsUUlb
	 CYL31kdb9uy1yNacxocOrZeGCvTTJZSR+AlPpYAbFg3RptWn/GVR6+RtsDffLoQsUM
	 fC305+MzadZX/PH5c+jukkUN8dOt6F7NqEMGt42IQjKDa1k/RnUB5w+DOzj3Qk10To
	 ZVxEWoGYI1jxw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E272547569;
	Fri, 13 Nov 2026 00:53:33 +0000 (UTC)
From: Suyuan Wang via B4 Relay <devnull+shyckless.gmail.com@kernel.org>
Date: Fri, 13 Nov 2026 00:47:28 +0000
Subject: [PATCH] vfio/spapr: Check the whole IOVA range in
 VFIO_IOMMU_MAP_DMA
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-vfio-spapr-v1-1-e3107da71f5c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB9e9moC/yXMQQqAIBBA0avIrBNSKairRAvLqaaFiVMSRHfPa
 vkW/1/AGAkZWnFBxERMm89QhYBxsX5GSS4bdKlrpZSRaaJNcrAhSluhLSvdDKZxkIMQcaLzm3X
 9bz6GFcf9PcB9P3bpoIFuAAAA
X-Change-ID: 20261113-vfio-spapr-a5ea0529b39d
To: alex@shazbot.org, tpearson@raptorengineering.com
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794531212; l=3170;
 i=shyckless@gmail.com; s=default; h=from:subject:message-id;
 bh=9BK/s46bs5g6IksgcgM4VCdYbHZgPl56YVsnMO2gB94=;
 b=uG9dqKsbXc/iJ+FJP43GK6Aj4pUwI+80tlxxpH7Pxo8VCcrTLl86bFrFV25OH7nrSaebJ3eyM
 rgtqDGgz8XnDkGxYvgadf+jfa6RcqyEpU2jdjSUgecW8FHRUUyKbL4q
X-Developer-Key: i=shyckless@gmail.com; a=ed25519;
 pk=pMtccVGiWES3bV+7YBFuBclkvq2n2HBHQ5azaBrK2lY=
X-Endpoint-Received: by B4 Relay for shyckless@gmail.com/default with
 auth_id=1498
X-Original-From: Suyuan Wang <shyckless@gmail.com>
Reply-To: shyckless@gmail.com

From: Suyuan Wang <stevewong@hust.edu.cn>

VFIO_IOMMU_MAP_DMA checks the request with iommu_tce_put_param_check(),
which only checks one page against the DMA window:

    #define iommu_tce_put_param_check(tbl, ioba, gpa)          \
            (iommu_tce_check_ioba((tbl)->it_page_shift,        \
                            (tbl)->it_offset, (tbl)->it_size,  \
                            (ioba), 1) ||                      \

tce_iommu_ioctl() then maps the whole size:

    ret = iommu_tce_put_param_check(tbl, param.iova, param.vaddr);
    ...
    ret = tce_iommu_build(container, tbl,
                    param.iova >> tbl->it_page_shift,
                    param.vaddr,
                    param.size >> tbl->it_page_shift,
                    direction);

tce_iommu_build() and tce_iommu_build_v2() write one TCE per page,
entry + i for i up to the page count, and nothing below them checks the
index. On PowerNV, iommu_tce_xchg_no_kill() goes through pnv_tce_xchg()
to pnv_tce(), which for a single level table ends with

    return tmp + idx;

where tmp is it_base. So a mapping that starts inside the window and
runs past its end writes TCEs past the end of the table. Each of them
holds the host physical address of one of the caller's pages plus
permission bits. v2 also stores the caller's userspace addresses past
the end of it_userspace, through the same pnv_tce() lookup.

To get there the caller needs an enabled SPAPR TCE container with a
group attached and valid memory behind the whole range (preregistered
for v2), which is what QEMU sets up for device passthrough.

VFIO_IOMMU_UNMAP_DMA already checks the whole range. Do the same for
MAP_DMA. This relies on commit 0b271f7d7f5e ("powerpc/iommu: Fix the
overflow validation in iommu_tce_check_ioba"), before which
iommu_tce_check_ioba() ignored npages, so stable trees need that commit
too.

Found with a static analysis tool and checked by hand.

Fixes: 5ffd229c0273 ("powerpc/vfio: Implement IOMMU driver for VFIO")
Cc: stable@vger.kernel.org
Co-developed-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Kaixuan Li <kaixuan.li@ntu.edu.sg>
Signed-off-by: Suyuan Wang <stevewong@hust.edu.cn>
---
Compile tested only, I don't have a PowerNV machine to try passthrough.
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 1c0eec228cc6..bf0df5a74963 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -952,6 +952,13 @@ static long tce_iommu_ioctl(void *iommu_data,
 		if (ret)
 			return ret;
 
+		/* The check above only covers the first page */
+		ret = iommu_tce_check_ioba(tbl->it_page_shift, tbl->it_offset,
+					   tbl->it_size, param.iova,
+					   param.size >> tbl->it_page_shift);
+		if (ret)
+			return ret;
+
 		if (container->v2)
 			ret = tce_iommu_build_v2(container, tbl,
 					param.iova >> tbl->it_page_shift,

---
base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
change-id: 20261113-vfio-spapr-a5ea0529b39d

Best regards,
--  
Suyuan Wang <shyckless@gmail.com>


