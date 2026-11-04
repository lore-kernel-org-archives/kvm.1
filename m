Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779648;
	b=orBLlhCpqQPf3cICVUsuoH4LjB4eha4mxG3UzWZzEKX5gUiqFlXbFUrNQG47Yii7AJkx
	 GPipUSa7x7XpSOkk4LIWiNdWMpl/XtvyqkQYdJ68i0TpvxWK6Doz5yQBzfuF0EN20SiRr
	 pLv3qresMgqqbpQlwrIUL0Ql9uGSXCaadH5mWVXDnNaKDR/QJ7/8viVpJgln2Ao11+G0Z
	 8Lh+mZgJU3R7yxmwBhUJJ/TYMB5zQkwKqOulmPd3DU6HwXk4j1BArJjbIhrSGNMMCnXxP
	 3pnl/FAkD8r3WDoI+xS8T2M6B0czR9zPs+7DIvcZVRiHxOhNVg0osNOTwdNqeq+FJTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779648;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ytD5dwCgDlg6m/rJ2WwBVWcBcKQbe9lxI2VBArWY798=;
	b=xg9iNoak6Y037c8Dv8Jj7MRCWzW4QnY6dyY2M/M7/t6SWmWWlrVKzGom01ErElOYguvn
	 9s1AI1QpDQ4dmntmjvphRfo9b5pywt2hTFpSQR07+yqKS1f+xkp3YbNnHAJ5H3PYBB0+J
	 ARDpodWckUixMj2ktURFJXB/aQeScHjEpXCvaOuPADM3M6913CSNnMiDokEF25OsIKB6N
	 Iv3ksIpyROhCHOmP+YDrJv1XL9D6STFSnhQuLBuoSK9druZM51w+qYJe0c2dtGvK00xjG
	 Wvqs7A+4qa/ZHVdbKaXQ+y0JQ6f7I7AAx2AvhsE067rLcY/bMxpD9eoOwNxfhX2OHmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="LRgxGaL/";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543AC606A326;
	Wed,  4 Nov 2026 08:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 543AC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=LRgxGaL/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=LRgxGaL/zT7G72tGkZAfQWjP+nw8KrhRHOvIzMQNwWpaKbzeTrAoKgNZk+qq94VTE5+88IpVxHY6n
	 rzDU6ECz3bJCeF02l7RcjWxiOphITA9fYEQO8t9TJeexvVYGftuRJvBNZUHPj9A/v7Q5iZyJHYNmPG
	 7RNgA+fIIebAyzWU=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16aeae7bd2e7-773ae;
	Wed, 04 Nov 2026 16:07:25 +0800 (CST)
X-RM-TRANSID:2ee16aeae7bd2e7-773ae
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from desktop-eb75daa8a6be458c-20260816004526035 (unknown[10.55.1.72])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76aeae7bb042-1a375;
	Wed, 04 Nov 2026 16:07:25 +0800 (CST)
X-RM-TRANSID:2ee76aeae7bb042-1a375
From: zhangchujun <zhangchujun@cmss.chinamobile.com>
To: seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	zhangchujun <zhangchujun@cmss.chinamobile.com>
Subject: [PATCH] selftests/kvm: check fopen() return in get_run_delay()
Date: Wed,  4 Nov 2026 16:07:21 +0800
Message-ID: <20261104080721.2169-1-zhangchujun@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_run_delay() passes the FILE pointer returned by fopen() to
fscanf() and fclose() without checking it for NULL. If the
schedstat file cannot be opened, the program dereferences NULL
and crashes.

The comment above the fscanf() call already says to return
MIN_RUN_DELAY_NS upon failure just to be safe, so do exactly
that when fopen() fails.

Signed-off-by: zhangchujun <zhangchujun@cmss.chinamobile.com>

diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index f5f7189f96a8..2827f7d7d905 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -421,6 +421,8 @@ long get_run_delay(void)
 	sprintf(path, "/proc/%ld/schedstat", (long)kvm_gettid());
 	fp = fopen(path, "r");
 	/* Return MIN_RUN_DELAY_NS upon failure just to be safe */
+	if (!fp)
+		return MIN_RUN_DELAY_NS;
 	if (fscanf(fp, "%ld %ld ", &val[0], &val[1]) < 2)
 		val[1] = MIN_RUN_DELAY_NS;
 	fclose(fp);
-- 
2.50.1.windows.1



