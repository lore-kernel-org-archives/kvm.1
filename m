Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2108346A0A
	for <kvm@vger.kernel.org>; Mon,  4 May 2026 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929347; cv=none; b=JjlCX295aYXcEp6+i51U/W8Z2f1NU7qntSGUpd4rbCNta9Y0tR5OJXv0rDTDuJktfp7N1P/mT8WFRRIEGc0786+fUFeMqSkGGKZ5AkiD1azrMRhZklkeno2MAoYSC3s8xdwXcSrWF6BZMbKyAWGtWWZXPHcjJACnMzi0NghSsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929347; c=relaxed/simple;
	bh=DklPH6/6YJ0p6u4Cf1PUxpd4itLk/dZorR5WDOT5W/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crSk5LBiiugIxAam/qQYZXEdrYjJ3uprBbIPm2hbe1JhXFJuPMzCLtzLDBM5oKafZlRjNwJGw1vrNGQujuJVxQEdAxRzuoay0moIfsv7ajKWr4mL2q3C+O7RMVVpjviSmzbzbpyFW2vF2/ge1n/DIStlh4h5Z/N+Jsd3CpSqvDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=khNLVBj4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khNLVBj4"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-835c98b659eso1018536b3a.0
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777929343; x=1778534143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JKpE5oRLemYbfg1MRy2f9zZjvjCWWH6F7jRfRxX1jLc=;
        b=khNLVBj4s5KuwBKGO9lJ/eqFzIsaK4KCG4wxZKNMPcAQ+Wn4tSOkIMa7+xeZfkE0IQ
         3wFfDaSM7aKJ7tAOwx6mOBeiBE8WMDL8FG64mRwSytpDDhYTVV9zxqzFnf4qocem4m1A
         Q4+h3WMazXtwwGvMdIgRuCns/ULO/NE5Mm3eZM+xBwLC9RJ/hmNkmXArWF+P2FqRgWpo
         kzPr/bJT6yDka0BgH8kQ15LdJqv5zEe13wipN0AXPaf3EYFO90kmSlHvuu2A7FxuV+TW
         qgI7HBYuOt+q9qGHJvR7VCt2OMa3CA41le3Fc1UEr9pkg1REKRRIeN+65f3hhLviS2Si
         tqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929343; x=1778534143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKpE5oRLemYbfg1MRy2f9zZjvjCWWH6F7jRfRxX1jLc=;
        b=VH0O5JjhxxaFgePdqUn1+XKYYamQwFpKg33QmxvACwGSQifWg+jV9mIpLPI0yotguJ
         dWI/1y5ySKbSiI4fiB2b1YfTp7mD2zDbdEYACVemeap12znVbCzH8V33ubZjiPZWvb8d
         T4Xd6qT3OgiGfiba2tMgyJ5qL/5zgHtMSXiGxij9k1CbcRe10Bmwo7FmbxSf2hCvfp8M
         q6EKlouEnmNqxb1xqNGY6f45QBhmf1DhBoVb3vQF5+5J5hUjjhSKT3ffqJI/Fa/NtX2X
         aItp9CD/CK4sri/JDd+kL5fSVBkX1Rd3pc7NUDzHQ9BWGE25KECp2h+LZoT70ATbxZUR
         uwpw==
X-Forwarded-Encrypted: i=1; AFNElJ8MJmjxVRd63lxYPH8Xuo7lw6upU3zTlmyMXnhLOMedagejSwIHYcWgQ+8Xzuexu20SxI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Tgtt01FFdvgM/bnsqIxYTU8f1BKydvZvMpRQQwTbcLsHgTb8
	+P1ELfpCeoIxBl0YhoMJnZHimcSKbYiZQGQmS9j+JSIYUpBmlI6M0i4/59H/Vlmmng==
X-Gm-Gg: AeBDietCwmC7BijHVluJ/RVuMRlqoCZAqk4hOKagf7sZB6IF0SpcwcbigEZ6e+rRIfF
	Loat5AHKmSBOJOwrM6ZnQJ98EAObFRDs2l7tTLwGbSEazEq6L/Iom7XvLbNDJkXpNRbMZHCj2X6
	ItfLB4Wj22qeKSukF5Jzf9mSg2nsfJLOBy8PTJreID2gI7poWLiDltL2AvBLhhc6TE61D0laliL
	WcqEwLZNWy9mesXoKVBzNKZSmkbwbJg4Wqu3ZXhVl+MGx0rUUckfFeO/g85hgnLmqx6GyJ11kFH
	653TiASPtgHcsOJBHm+orqZErEMaqCcXZdU45a02WSWTQ13MbqvJA/2seT8Znz7Wr9kMyAmKxK+
	LP8xK8XEzr8PHuGJ8JPI5obG8YvjKmBYQT5bJ5PvXQcPa/a50P4lYH4sl4dj3U2VbtI7uwRteIO
	NyYaht8I8ZB/C/PfcoDxM8qGwg5Vqw7Ek7TxXDaoxeNNzaR+mgQE2KciLmQuTtY23oEO8DRH4vo
	ufc+g==
X-Received: by 2002:a05:6a00:428c:b0:829:9a7b:db84 with SMTP id d2e1a72fcca58-8352d2f425bmr10106522b3a.49.1777929342450;
        Mon, 04 May 2026 14:15:42 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83943dde006sm41031b3a.10.2026.05.04.14.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 14:15:42 -0700 (PDT)
Date: Mon, 4 May 2026 21:15:38 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH 08/11] vfio: selftests: Add dev_dbg
Message-ID: <afkMenQ_gfmLUJIy@google.com>
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <8-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>

On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> Enable it with a #define DEBUG at the top of the file. Allows leaving
> behind debugging prints that are useful in case future changes are
> required.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .../selftests/vfio/lib/include/libvfio/vfio_pci_device.h    | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> index bb4525abd01a22..2d587b988c09fa 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
> @@ -38,6 +38,12 @@ struct vfio_pci_device {
>  #define dev_info(_dev, _fmt, ...) printf("%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
>  #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)
>  
> +#ifdef DEBUG
> +#define dev_dbg dev_info
> +#else
> +#define dev_dbg(_dev, _fmt, ...) do { } while (0)

Can you add something to make sure the format strings are still
validated by the compiler even if DEBUG is not defined? (since it
will almost never be defined). e.g.

diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
index f4ebd122d9b6..406c430ef28d 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/assert.h
@@ -51,4 +51,9 @@
        VFIO_ASSERT_EQ(__ret, 0, "ioctl(%s, %s, %s) returned %d\n", #_fd, #_op, #_arg, __ret); \
 } while (0)

+ __attribute__((__format__(__printf__, 1, 2)))
+static inline void check_format_string(const char *fmt, ...)
+{
+}
+
 #endif /* SELFTESTS_VFIO_LIB_INCLUDE_LIBVFIO_ASSERT_H */
diff --git a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
index 2d587b988c09..3abfa6ff481c 100644
--- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
+++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_device.h
@@ -39,9 +39,9 @@ struct vfio_pci_device {
 #define dev_err(_dev, _fmt, ...) fprintf(stderr, "%s: " _fmt, (_dev)->bdf, ##__VA_ARGS__)

 #ifdef DEBUG
-#define dev_dbg dev_info
+#define dev_dbg(_dev, _fmt, ...) dev_info
 #else
-#define dev_dbg(_dev, _fmt, ...) do { } while (0)
+#define dev_dbg(_dev, _fmt, ...) check_format_string(_fmt, ##__VA_ARGS__)
 #endif

 struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct iommu *iommu);
