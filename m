Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011842;
	b=pO+EUx5rlK7LzLWa7fgNp7mMZTGvJ8eNJbuUxmp/yOFgM6w6BeoJbo87CIa4teKzlm5u
	 QBpvEkHcN8yr6XTiq7i4u4smw8diO9utp40a8jcBs/WDNWd0O+XO7yDvqQV9HUuT3eFq8
	 /Ov6+WvEIMNqY3hoaLSZ7EDwE4bEM8dnA2Xf6c6b0Pu6FPpVXeY4qy6boZmhsFf4ZeNOW
	 4yPvUwIKyYoRoPg+AcW939Eb6L9r1xhkQsBE6e+dCg+1lWAJRSNF5GzKdDktJpul48wyQ
	 kPc8HxSsf90j6E67Dzx1dpQb3XfGCfXyinzIQXDOqmwHYWaiHoWNQnziUkRvHR1n6Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011842;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sxqsi8+toyrpTaa7l33gT+8/FQLeWRcGY9DZTW0jNlc=;
	b=eab9k6maIqbeP47dPyVCHwTDO02IqBXDSnCqaa+wygVq7DS9fMLzBzDhYugEH7kyzfe9
	 llinNw2xgUkC4cO10s0b+msqv4+WXDiOvbIrpeZgOPuhi7AoR7hiXsgaEYZJrdqk1FCrZ
	 +MTB//FW+TlkhTULq7XDlk/VirVsVYkg7buV2Jl6j+h5QYEqvvfujyHN+P0xPT6J4HkuW
	 vD0iKBeIOLk74b313q+kkcpSv9MIW73ToVuXWMoBGqkDIgRtEafkMsXrzwDrpqNMA6QAI
	 VehQnQPj7Fp5gKVZ1FNNjatjZs0AMcMAUqN5am3IOw5VqF78Kzvi2Ok7iVItP7cN9Pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoR1VlJm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ACF606B779;
	Sat,  7 Nov 2026 00:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UoR1VlJm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011841;
	b=qUABWoYQZFC7EY34Kr38ZCoujYBCxmdwpNYmyaAz0Lr4WCX+E+C9elbHuUuY/y2JbbRc
	 TWS1hIE+TEsGuErLP3TN8xy5dMxgUixYZWYPW4VYvkjLTUZrKIjmPHXXZ5C0oGdg/SQ6n
	 mEzEgLLab4XH/7LDfnjtR37BQlcPPHrDrWQzfWbptynK5jo6fE1MXBz/8YdvJIbrx+dP/
	 kdudRrX7jPEPCl5KaIyTJTpUTCcop5It/7pZAAl8+Hlf68AJTzmuu8OKcvgdbK1v4PdTB
	 wvRMdSgwN3lGBCwdIDEBRP9aA61xoa/0zQ6xFBWu3NeSWU6v6khhcXoLEWxyhhQrd/Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011841;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=sxqsi8+toyrpTaa7l33gT+8/FQLeWRcGY9DZTW0jNlc=;
	b=Wo0J3QzYBnZlX5hx1iqM3tpVTnFCSreQemxvxBpivmGlT6t8c+DnIXMbyROU2bEg8EGS
	 s3zs8t9Bpysn7PyMuVSbvi9irSK1iUAJmuCU99jIGOmcuQOJkmkW5ceU/R9ia4fU84fYA
	 apkIVqlOKkpwtw1cT/MpkQB3mn9cYf5gAOTp6my6iA8W7yv3ViqAHf+wFP9ZG4VyFRJlw
	 m4ebeCleD7YbAF3ri9Gko5/qp1Q6+ci+TmYBE9YHmN4XTfhc5KB+5hQ7HmYlwOry51xqJ
	 yL4MbPQBoOYPgGa0kPhYOj13ndt2ilVULBbqQR/z4bCvQDt64gtzZXLwLJ7dZwr6Yzw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0AA231F008BF;
	Sat,  7 Nov 2026 00:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011841;
	bh=sxqsi8+toyrpTaa7l33gT+8/FQLeWRcGY9DZTW0jNlc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=UoR1VlJmvBnw2565e3nIFjL8HA/IsIFk5h10Dza6vZUgg+EU2aECgR3BBHS90PTDp
	 c1zpA5/n27GNgnKBRXFD9nXm48HUKZ9YiQ1SPU1XMkagsFKf5KHL6TVo6K3WEM8hUe
	 DqNSivmaE0I5tuM1e8KANO6TY9Hwqj+ktBDQZyI7nlUUEcZHaTqNcY+Rvtwy6s+Khp
	 RejGcfGI27rUQ32aFmlKPE7t3qem25R7GU4syFv0pnjsMF7JjYmSqEUoxQw5dd03+9
	 DOv2pOgOZuuTtvTOC76WrnZONO2LjFP8Id0VDlICpcwy2E8Mcz9G/uxwWkzk9ok+2R
	 upJK9KJKo9uzQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 35FE547A46;
	Sat,  7 Nov 2026 00:36:58 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:53 -0800
Subject: [PATCH RFC v3 79/88] KVM: selftests: Verify BAR revocation and
 access gating in low power state
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
Message-Id: <20261106-gmem-alternative-providers-v3-79-8484dde66a7e@google.com>
References: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
In-Reply-To: <20261106-gmem-alternative-providers-v3-0-8484dde66a7e@google.com>
To: Alexey Kardashevskiy <aik@amd.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 David Hildenbrand <david@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Fred Griffoul <fgriffo@amazon.co.uk>, 
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jianxiong Gao <jxgao@google.com>, 
 John Starks <John.Starks@microsoft.com>, 
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Tarun Sahu <tarunsahu@google.com>, Vishal Annapurve <vannapurve@google.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011810; l=4274;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=HXOqCEcn1wMNNgFV4ufgWpq3HP3d5KMTONODuY/LkjQ=;
 b=hfJIou2E40cEogfjGxqpPpOHJzj8+eMJz0hE+mUJsmyO3SWxtyR789XZaiT8+HTKnEdUzJ2If
 Q0v4pcLysRCBmrNVjh3IoBZrnVwu9QVRWFtl+wJj7s9Fai6Pwzf069q
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

When a device transitions to low power state (D3hot), physical BAR
access is invalidated. The kernel revokes existing memory mappings and
marks the BARs unavailable.

Add a subtest to verify BAR revocation upon entering low power state.
Populate BAR0 mappings, write a test pattern, and enter low power mode.
Confirm that host mmap access to the revoked region raises SIGBUS and
that pread and pwrite on the BAR descriptor fail with -EIO while in low
power mode.

Exit low power state back to D0 and confirm that host mmap access and
pread/pwrite operations are restored and succeed again.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/x86/guest_memfd_vfio_test.c      | 86 ++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
index 03c324f7f618d..cf2d46a365504 100644
--- a/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
+++ b/tools/testing/selftests/kvm/x86/guest_memfd_vfio_test.c
@@ -443,4 +443,90 @@ TEST_F(guest_memfd_vfio, device_reset)
 	ASSERT_EQ(0, munmap(bar0, bar0_info.size));
 }
 
+TEST_F(guest_memfd_vfio, low_power_bar_revocation)
+{
+	struct vfio_device_feature feat = {};
+	struct vfio_region_info bar0_info = {};
+	ssize_t ret_bytes;
+	uint32_t val;
+	void *bar0;
+	int ret;
+
+	vfio_pci_enable_memory_and_bus_master(_metadata, self->vfio_fd);
+
+	bar0_info.argsz = sizeof(bar0_info);
+	bar0_info.index = VFIO_PCI_BAR0_REGION_INDEX;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_GET_REGION_INFO, &bar0_info);
+	ASSERT_EQ(0, ret);
+	ASSERT_TRUE(bar0_info.flags & VFIO_REGION_INFO_FLAG_MMAP);
+
+	bar0 = mmap(NULL, bar0_info.size, PROT_READ | PROT_WRITE, MAP_SHARED,
+		    self->bar_fd, bar0_info.offset);
+	ASSERT_NE(MAP_FAILED, bar0);
+
+	/* Probe support for VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY */
+	feat.argsz = sizeof(feat);
+	feat.flags = VFIO_DEVICE_FEATURE_PROBE |
+		     VFIO_DEVICE_FEATURE_SET |
+		     VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_FEATURE, &feat);
+	if (ret != 0) {
+		ASSERT_EQ(0, munmap(bar0, bar0_info.size));
+		SKIP(return, "LOW_POWER_ENTRY feature not supported on device");
+	}
+
+	/* Populate mapping and write test pattern to scratch register */
+	WRITE_ONCE(*(uint32_t *)((char *)bar0 + E1000_RAL0), 0xdeadbeef);
+	val = READ_ONCE(*(uint32_t *)((char *)bar0 + E1000_RAL0));
+	ASSERT_EQ(0xdeadbeef, val);
+
+	/* Enter low-power D3hot state */
+	feat.argsz = sizeof(feat);
+	feat.flags = VFIO_DEVICE_FEATURE_SET |
+		     VFIO_DEVICE_FEATURE_LOW_POWER_ENTRY;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_FEATURE, &feat);
+	ASSERT_EQ(0, ret);
+
+	/*
+	 * In low-power state, BARs are marked unavailable and mappings are
+	 * revoked.
+	 *
+	 * - Host mmap accesses trigger SIGBUS because page tables were zapped
+	 *   and get_pfn fails with -EFAULT while in low power state.
+	 * - Host pread() and pwrite() on the BAR descriptor fail with -EIO.
+	 */
+	TEST_EXPECT_SIGBUS((void)READ_ONCE(*(uint32_t *)((char *)bar0 + E1000_RAL0)));
+	TEST_EXPECT_SIGBUS(WRITE_ONCE(*(uint32_t *)((char *)bar0 + E1000_RAL0), 0x12345678));
+
+	val = 0;
+	ret_bytes = pread(self->bar_fd, &val, sizeof(val), bar0_info.offset + E1000_STATUS);
+	ASSERT_EQ(-1, ret_bytes);
+	ASSERT_EQ(EIO, errno);
+
+	val = 0x12345678;
+	ret_bytes = pwrite(self->bar_fd, &val, sizeof(val), bar0_info.offset + E1000_RAL0);
+	ASSERT_EQ(-1, ret_bytes);
+	ASSERT_EQ(EIO, errno);
+
+	/* Exit low-power state back to D0 */
+	feat.argsz = sizeof(feat);
+	feat.flags = VFIO_DEVICE_FEATURE_SET |
+		     VFIO_DEVICE_FEATURE_LOW_POWER_EXIT;
+	ret = ioctl(self->vfio_fd, VFIO_DEVICE_FEATURE, &feat);
+	ASSERT_EQ(0, ret);
+
+	/*
+	 * Access must succeed again after returning to active D0.
+	 */
+	val = READ_ONCE(*(uint32_t *)((char *)bar0 + E1000_RAL0));
+	ASSERT_EQ(0xdeadbeef, val);
+
+	val = 0;
+	ret_bytes = pread(self->bar_fd, &val, sizeof(val), bar0_info.offset + E1000_STATUS);
+	ASSERT_EQ(sizeof(val), ret_bytes);
+	ASSERT_NE(0xFFFFFFFF, val);
+
+	ASSERT_EQ(0, munmap(bar0, bar0_info.size));
+}
+
 TEST_HARNESS_MAIN

-- 
2.56.0.455.g6c5a503b38-goog


