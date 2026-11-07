Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794011833;
	b=dXc9T7CtcimHDQLqZGJ18U52mkoCG60m4sJABkRQG/lCoWkoV+XopIdfMExsvVptl2s8
	 KW/ocg4w/oTF+qQYHL02cv9cdGh2UMx5LMaa5LOAQcu5Pm54+z4H02UflYI8YuQrBqa2N
	 LPWxruG2I/XGGawZg9nMypwzvOBIY6lAG0atH6+GNM97bvHtAxPUit4Cq8byhF0Pi4rEa
	 2nm/4S74i3QAYDc9ao31ydgbeMGOsvPJWY2Isb/RC9WlfrQ02YW+38g25FdyJvN4btIsj
	 FpECHY/8isaGamdzZFq3hrQNX/swdv2kFrf9R16pGZU7tkmE244F8L8wV/GAhFamvgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794011833;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TmrtUeRqg7PNOFUzBw0KGjO6eayo5TE17ZzIRnG1rFg=;
	b=RmLT0+SM4UBglyHppeuHfX37/quTjFAB2SvjOZ4vuF2NcHirk1a2jVcHL6UH8E38Ic00
	 LzXJEd/4zF+txYhQaqODln2iADl4Q+nOLz4q6R+maTiienD5KuUDzQ24veMSvi7L51hXa
	 wF6BMgkDRMqo0an0YBBgQtD32FfhdbtA3tLix8IJoiHxVVi6hh2tEIIcu0jkKR43da78P
	 Hn/jeDf9erTODdR95XUkU5m9kaIxkZ8xmAVFY5MSKiB9x8R/SQ2BZnUf+5mOq48arnXLX
	 4m7q5Rf6qMZiErJZWbOxBmdx26jnVroLhnhLw7X+pFyx0c5ugnAtBBRLuteftXFjvzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpFvUw8I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43110606D834;
	Sat,  7 Nov 2026 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PpFvUw8I
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794011833;
	b=pmBs4c4npqjzKE6M1rBYxQU9MJpNGg+HZ48YxljZxWO0ZU+xJT7J05zcxDRNK3pE3pAF
	 gO3KmkMYi+JmCF/b2FjFx2Y34vA/wdUDurBZJx95SHLaAel4HV7MMfxAPaNYXVSEjUiY/
	 TSbpp/Iz+j+Z+d3KXRIrmXMMEYqz0m0p59st4LzBOrbj0XlNCcrq04voYrQLtjC5eolVH
	 30WPulrhDX2h+c2xTLopF8TAzvHiPpQKYdVEWMP03ZhLhr5cU1bCg03b4+VIAvvqAQyuC
	 SNstjoxfldPs22KFnA9moiVBDKyGq9UZHEvMjEWVLo5OXvkjALskkR57u7jQTOHuQEQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794011833;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=TmrtUeRqg7PNOFUzBw0KGjO6eayo5TE17ZzIRnG1rFg=;
	b=ojY1UX8j8Fan7G2I0aO9foYknP17k+NMntmMCiNldQIIRjpPVxf2Zq7ZQfwnwDHpPCjd
	 G1Y34YuTn4KyW+UI+tMFI11iZbiwfjqQ1qn6cjX8FWOoZ8k2T3TdVBmQBpM0Sa8bKDq/B
	 J27fal414xBhp7xnGXHe8iiBM3n7l37Azwh3fJ4lOBq0DeS3IzWIpjIZZWNFoEGqoBmeU
	 iYez0rbSAJM76Ba/YPGRJZm/UETyfrV3Af3wIxC7eq9xXFE4nQJIDYlFbn4+mmcLCc4Uk
	 wc+kmMn5I1CJY8ZaCEYHZdCASNNWynCLaUx82k3gmhH1erXGX0oFX8RGX4h1Ub29AlA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 04F2E1F008A1;
	Sat,  7 Nov 2026 00:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794011833;
	bh=TmrtUeRqg7PNOFUzBw0KGjO6eayo5TE17ZzIRnG1rFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PpFvUw8Ij2hlXN/rTJjtjG5HETyrJIxnsjAgb1z50jOmZ7IMyxVnv/CFZIUldh4+d
	 viGZpBtJRsvrQlIh9hdZxXcnIZRbf24fOtGY7Ixi7hHiPoV+UYGqZDthmb75yPM2Vr
	 b3cN/Qo6H54aLQDSF+6+lO3aZwHEozxGcQgGPcExNF6N6yRDRBxL+CQYSYmD0QvYA8
	 e7l+CnG0z0hYqZjdT3kYTTzH/ovTKUfcz76aYVmDDMFGZ2v3isF0jl2txCpAAC4y0a
	 8QlZ3+6GkmH0SdQWpUdFV+cDxqJQt1ufPJP3Od0iFUKgXgblSypma+5U0LIxNGnti9
	 agBYxqDCtRJlg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C59D24797F;
	Sat,  7 Nov 2026 00:36:54 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Fri, 06 Nov 2026 16:37:01 -0800
Subject: [PATCH RFC v3 27/88] KVM: selftests: Test marking page ranges
 read-only
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
Message-Id: <20261106-gmem-alternative-providers-v3-27-8484dde66a7e@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794011809; l=3249;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=XtGmSBvwOq6lpm/Qp7pMrqoe2YFfpDhrMdOnKzGerIY=;
 b=RXpFZ/blAE/3OlyVi7XMW2Xei66nvIUzHHFOSfE75D2vfh85PBi5IfkkJ+1wpMS4aYJ6CUKUq
 34KHhBOxIVrCRV7i1xAF5/fCYc/JXC3BQwLYdYffAjRGjZyv6UyUMx4
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com
Content-Transfer-Encoding: 7bit

From: Ackerley Tng <ackerleytng@google.com>

Test dynamically marking page ranges read-only and writable via the
sample memory provider interface.

Verify changing page write permissions and ensure that read-only page
counts in statistics reflect each change accurately.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/mem_provider_sample_test.c       | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/kvm/mem_provider_sample_test.c b/tools/testing/selftests/kvm/mem_provider_sample_test.c
index 8fe634b0b4f2e..942c0519836de 100644
--- a/tools/testing/selftests/kvm/mem_provider_sample_test.c
+++ b/tools/testing/selftests/kvm/mem_provider_sample_test.c
@@ -136,6 +136,70 @@ static void test_set_present(int dev_fd)
 	close(fd);
 }
 
+static void test_set_readonly(int dev_fd)
+{
+	size_t page_size = getpagesize();
+	uint64_t nr_pages = 4;
+	uint64_t file_size = nr_pages * page_size;
+	struct mp_set_readonly sr;
+	struct mp_stats st;
+	int ret, fd;
+
+	fd = create_provider_file(dev_fd, file_size);
+
+	/* Initially all pages are writable */
+	TEST_ASSERT(!ioctl(fd, MP_GET_STATS, &st),
+		    "MP_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.readonly_pages == 0,
+		    "Initial readonly_pages mismatch: expected 0, got %llu",
+		    st.readonly_pages);
+
+	/* Mark page 1 read-only */
+	memset(&sr, 0, sizeof(sr));
+	sr.value = 1;
+	sr.offset = page_size;
+	sr.len = page_size;
+	ret = ioctl(fd, MP_SET_READONLY, &sr);
+	TEST_ASSERT(!ret, "MP_SET_READONLY (read-only) failed: %d (%s)",
+		    errno, strerror(errno));
+
+	TEST_ASSERT(!ioctl(fd, MP_GET_STATS, &st),
+		    "MP_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.size == file_size,
+		    "size changed unexpectedly: 0x%llx", st.size);
+	TEST_ASSERT(st.readonly_pages == 1,
+		    "readonly_pages mismatch after read-only: expected 1, got %llu",
+		    st.readonly_pages);
+
+	/* Mark page 1 back to writable */
+	sr.value = 0;
+	ret = ioctl(fd, MP_SET_READONLY, &sr);
+	TEST_ASSERT(!ret, "MP_SET_READONLY (writable) failed: %d (%s)",
+		    errno, strerror(errno));
+
+	TEST_ASSERT(!ioctl(fd, MP_GET_STATS, &st),
+		    "MP_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.readonly_pages == 0,
+		    "readonly_pages mismatch after writable: expected 0, got %llu",
+		    st.readonly_pages);
+
+	/* Mark all pages read-only */
+	sr.value = 1;
+	sr.offset = 0;
+	sr.len = file_size;
+	ret = ioctl(fd, MP_SET_READONLY, &sr);
+	TEST_ASSERT(!ret, "MP_SET_READONLY (all read-only) failed: %d (%s)",
+		    errno, strerror(errno));
+
+	TEST_ASSERT(!ioctl(fd, MP_GET_STATS, &st),
+		    "MP_GET_STATS failed: %d (%s)", errno, strerror(errno));
+	TEST_ASSERT(st.readonly_pages == nr_pages,
+		    "readonly_pages mismatch after all read-only: expected %lu, got %llu",
+		    nr_pages, st.readonly_pages);
+
+	close(fd);
+}
+
 int main(int argc, char *argv[])
 {
 	int dev_fd;
@@ -144,6 +208,7 @@ int main(int argc, char *argv[])
 
 	test_lifecycle_and_creation(dev_fd);
 	test_set_present(dev_fd);
+	test_set_readonly(dev_fd);
 
 	close(dev_fd);
 	return 0;

-- 
2.56.0.455.g6c5a503b38-goog


