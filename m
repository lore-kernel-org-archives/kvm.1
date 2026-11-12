Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794480836;
	b=JMgE24owoXeH6ObRHs5GXYzfowO0utAKTkpv2dM/EMQcRDkt/568YN+c1H8aY3A1w+r8
	 4XGysM53AuscuqwXeczpA4AUXe3J6IDwaOt3AhqITCZ+sySuHFgvsuh7lWk3Nk5n8W/38
	 AaXaWIHw/cZOc/LMYrMQaOLr1YXE6hnPyt1HaHbGYVnWqTJMUhXqhcrSv7OjCuVtxmQzC
	 J738tTkHNrsCEYIRBmtanvhyKx6dAUZm2UGPkyVJZY+Lsk3OnXSZsurKtNaDpU2Fvz6MW
	 c3EGsYZjc2yvoDZqLag8raNd3HR76iuZkxpsDebcePuGusi9qeoi9PrrEyaj4Rxc81A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480836;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Mailer:X-Mutt-Fcc;
	bh=x9FymSRgKEmF3YLVaEmXV+qBe5FB2zMq7gJot0C8RFA=;
	b=ZvHGil8bp5Khyq/knjg7+Ryoqrg/cZdse3ofifp9WT6Poted189hI7v+uxaOQp+8UrKT
	 bG64sVk62jEPA4YNvJEWZKz0pKYj4kyp16U2JiMNe8rvs3IjiGsNlCAQNVIpAJHe1hK6J
	 2kiNlasU7DA4d28f9VRRX/He9CSQy8F1e5OOBzSzZlFYfj8A1FXLoF688po5nZYgc+dhC
	 mSYyjYAGzXRcKcWhd56NTUCynFmZdV7DCEZviFAuBJDag5+AvwPyrZQZxqLyO2Yhn+eDs
	 ZLwkPlekkkZOG50ryiuMJBC7RBLzJBEt6Spaccd4PNQiYXSgXe4r/P97zRgtN4A3hBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbIsmZyd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kYxzWQLj;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D460606A31C
	for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 10:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D460606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gbIsmZyd;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=kYxzWQLj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794480834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=x9FymSRgKEmF3YLVaEmXV+qBe5FB2zMq7gJot0C8RFA=;
	b=gbIsmZyd951GkYAeuc5ZVvZPM6iBmnW+NSEqvDeWCvQAXHsX3ABjnR0P4lGihKq90YfK6Q
	muIHNQdA/M0Q1Y76+xl/OBmt0j83U64zG185sJiLibkqkTSIltYKflwrqnOukKVyKoCKs/
	u1a6BAw5KImAlk18fDj78C4Fx2PVzbU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-VYJKGR6NPIqLgOasdCV8-A-1; Thu, 12 Nov 2026 05:53:52 -0500
X-MC-Unique: VYJKGR6NPIqLgOasdCV8-A-1
X-Mimecast-MFC-AGG-ID: VYJKGR6NPIqLgOasdCV8-A_1794480831
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-499ca65ae87so436499f8f.1
        for <kvm@vger.kernel.org>; Thu, 12 Nov 2026 02:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794480831; x=1795085631; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x9FymSRgKEmF3YLVaEmXV+qBe5FB2zMq7gJot0C8RFA=;
        b=kYxzWQLjAgb7uaSd94J0/GnE3e+uslJh0T7nLI6J5Y2CPFK/vi8ve70V/KvrFhlfXb
         2wV37QFKMOalUGJOTR9LzckAGvWSY7r/9RLfD/ATIjyHIUQFfjaU4/QzASTHohMie+L2
         3JdblAlJUCqEAT9YOF+ROtjzjTpVkvTIRndO2HpUNCaV29bS0yw1R+vbbW1aSgU+pcco
         xkboxj70uy73V4m802XAfLuy1zMD4g3P4ktC2GK9pgPGXZM4Y+DJ4vqpTtLiDak85cCl
         j11asEvqARn4jN0bKjaFP20rZ4PCbWURM7+xQXgbCPhzVRf4LcCZ1QFPC1ropbmu3nmr
         7Atg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794480831; x=1795085631;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9FymSRgKEmF3YLVaEmXV+qBe5FB2zMq7gJot0C8RFA=;
        b=J7L4+Ikbtpns3FJNxBnNoTFHJ/xaSq4NPNmjzZLuZJf38YBAEOOBL9KeHRWGCfbZ0X
         e3SHcPLlI3S4nDdxRE8+/oEyCThPOgErDxbFKbmFbMnIa/scKkHHE83JYLSTz1fdoexF
         84Z3QX/nu1WMdHN0puEAas/0ybfA2HXpI14KmwzncyvJ2aTNPtAZZb9Y57p6yaRFhVpH
         5fY1dzkVl3IdAeWR79xsUomEs3BHPihpO+1XSgNXDU9T6fyN4AakB1RVUDs+miUw2t/U
         A3Xephceh1v4Be0/9FSGIj4tktBHjMR+dBLmjScCLxa6G64vMETsFBVPxVA3HmZVnL2B
         nCvA==
X-Forwarded-Encrypted: i=1; AL+hErFcjRovB3XedpVbpCYgpIIxHw+PYcv0d7OB6VFLhIURCTAs4qJHNju9qVZz6oZUHWR38jo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qwj8aZr28JNzMQip8psrNMMBK5oalhdCXZcMjltZdpG5If3q9
	fKoa1AgU5uTKNF5ZV/cFWmSeDoJpEyHVw33uLwHrGiT/K/yMFfPXfTOurO7D6wtn3iwkidBUvuS
	WwEGYKDYGkg7qNBGAHF1zojb3ZcEPJu45/DyobHQCaWKa1o1akkXk5Q==
X-Gm-Gg: AYBFou1ycrOFO9t2aelpP5IAka7rXDkzUIvucOn5/RtLSDOZq94z9XxhYCQ3ATIfiHl
	Udr/44N3NgNIioL8IF2c/Q+UOTk5rsGZrMyCwdjyiZyjKo5NDuLU8yB3gzS3cu1hqk+DKgC1vQ8
	r0laGEG/4pRAL+XaVwdXH5TzztKFY7ZyTRxrFMEdylF1cOrh6evlnQDnrEg4RjcaktOLUj1DdjH
	KZX15rD92Sosj4mSs6eBiH8/yB7U7wUz+uh/Xx7O4zb518HjNLdKLUMG5Abi2uzdHSdgFzQvuw7
	/RLXQP/pnmi+pSNyKhZJgY+Q0mAK+QlVcgRd9PW7NUNekExxM6Bw7k4MKEIZeXvua4LHqh2KWj2
	UbyfD/WWDfIRZrBx9tfijWRJcFy/Q+qSRMR/wxmaeqg==
X-Received: by 2002:a05:6000:4211:b0:498:364d:7509 with SMTP id ffacd0b85a97d-49b02d4cd48mr4648420f8f.24.1794480831201;
        Thu, 12 Nov 2026 02:53:51 -0800 (PST)
X-Received: by 2002:a05:6000:4211:b0:498:364d:7509 with SMTP id ffacd0b85a97d-49b02d4cd48mr4648361f8f.24.1794480830624;
        Thu, 12 Nov 2026 02:53:50 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1511:2900:ff37:b35c:a97:952d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365cbeedsm15992928f8f.43.2026.11.12.02.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:53:49 -0800 (PST)
Date: Thu, 12 Nov 2026 05:53:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Khan Zhao <zhaoguohan@kylinos.cn>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH RFC] vhost: set dirty log bits without pinning pages on x86
Message-ID: <af7f05bf637337d35fdd10f3e0dbb5e39d7780e7.1794480795.git.mst@redhat.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent

vhost had a TODO to replace page pinning with a version
of set_bit that works on userspace memory, since forever.

It is really best to avoid GUP on fast path entirely.
Implement set_user_bit and use it in vhost, to do just that.

Should not be too hard for non-x86 too.

Reported-by: Khan Zhao <zhaoguohan@kylinos.cn>
Link: https://lore.kernel.org/all/20261112085631.128819-1-zhaoguohan@kylinos.cn/
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---


lightly tested. pls test and resubmit with your tool.

 arch/x86/include/asm/uaccess.h | 18 ++++++++++++++++++
 drivers/vhost/vhost.c          |  7 +++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 3a0dd3c2b233e..ba1e7c3f83c8e 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -594,6 +594,24 @@ _label:									\
 	__ret;								\
 							})
 
+/* set_bit() on a byte of user memory; returns -EFAULT on fault. */
+#define set_bit_user(nr, addr)					\
+({									\
+	int __err = 0;							\
+	__uaccess_begin();						\
+	asm volatile("\n"						\
+		     "1: " LOCK_PREFIX "orb %[mask], %[ptr]\n"		\
+		     "2:\n"						\
+		     _ASM_EXTABLE_TYPE_REG(1b, 2b, EX_TYPE_EFAULT_REG,	\
+					   %[errout])			\
+		     : [errout] "=r" (__err),				\
+		       [ptr] "+m" (*(u8 __user *)(addr))		\
+		     : [mask] "q" ((unsigned char)BIT(nr))		\
+		     : "memory", "cc");				\
+	__uaccess_end();						\
+	__err ? -EFAULT : 0;						\
+})
+
 /*
  * We want the unsafe accessors to always be inlined and use
  * the error labels - thus the macro games.
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2f2c45d208832..9ba16cbd788cc 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2405,6 +2405,12 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_ioctl);
 
+#ifdef CONFIG_X86
+static int set_bit_to_user(int nr, void __user *addr)
+{
+	return set_bit_user(nr, addr);
+}
+#else
 /* TODO: This is really inefficient.  We need something like get_user()
  * (instruction directly accesses the data, with an exception table entry
  * returning -EFAULT). See Documentation/arch/x86/exception-tables.rst.
@@ -2427,6 +2433,7 @@ static int set_bit_to_user(int nr, void __user *addr)
 	unpin_user_pages_dirty_lock(&page, 1, true);
 	return 0;
 }
+#endif /* CONFIG_X86 */
 
 static int log_write(void __user *log_base,
 		     u64 write_address, u64 write_length)
-- 
MST

