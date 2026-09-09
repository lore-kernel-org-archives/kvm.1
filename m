Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96983BBFD8
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990074; cv=none; b=ql4KiglWYVqiUhy6/nsKx8JdpNQOcux3jKxgNB8DPWKuwvLNaGFJVcri7+4UdwlN0EJN16i1Hvn+P1HBgEV47tkXu2l8mac2b8AL3nJqD8cMdZt6WVDZB737y4ft4Rn9PpHE/HNoYpMKVbwxEmxa9bFlGgb0GSC97WTULfJITkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990074; c=relaxed/simple;
	bh=EqoYwk4Ts62ySjDOF/6WGrqI75EaG2zkY0Xm84rY1As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMEH0QpoB13goQDg5Uyzn7mnBN5A6exsJaERi+i5PTPPs0yGsjBw/8LaeSjcFS3rUGAN4OVOPB36UAQ58Ov7YxmKtp2vQ3ZdIQROQLS9VEmCQ1kRdH4X4/0aJWkmUZ5Jk630pCWHykDbfRmzvcz4cggTA2CBF1aLyrQmakl/3a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f+5R6J2/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+5R6J2/"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c73645a1so5017201a12.1
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788990059; x=1789594859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=laxcxAy6OrDTYTV8oVpLvlCb5cwnJq4gntL3hU2NYlg=;
        b=f+5R6J2/0Nytfk6I1eX1iPbdAA0qUgmSEwiCcCwIWP48kY4/urMMoYSyDb5xDgXxUu
         1czDmgtbYcBTqwTE/oZwUPZV+GqqUnIMpD0MaoUHRDjm0fbpz+9JVQrXOBOlLpINuykr
         FLpbXY97yYe52miWFQn9tn8YbwB+eDoOjGmgchKxfCHvEF86O7+kTBPAb07ui04/u7iE
         RA5I3EpyPdpgsxwqsydS/5QUzIp8jhHKXCgScE3XEw3jhWs5QW/g3997kZP3EmFYqQG3
         s7Kw2ZEtFtaTp8F2LaRy+QGLQVDnUcM0GAMH38vCdZUT/WNJ1rRrzOeURqZ8cU//4fHm
         Biug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788990059; x=1789594859;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=laxcxAy6OrDTYTV8oVpLvlCb5cwnJq4gntL3hU2NYlg=;
        b=hp0vdFDpA05KAOZtVsy0ka1fJlOSuMqSSo4a1UFQ3EauqEqeaHKtBKRNkTsnXa/uHC
         qqlgUiebB+CgYG9f+rlFujhWrkTqnNYksItiYkw4T28A4pggxX1t4snG/J0ziH8MqWS9
         8C+Ngn7cVJDUbWDYaX20P9emcAclK/wvkaaVzDhIic2O6L1tIpJ2KsfdLM67YgBn8eFA
         /0MBTyOFitRkvz38EuimA2tK8gPAyp9JutFhm8kq7e32xgEFpeH8sVFK8RWOlHZcqIRm
         dmvcYyrEb8VJnHVxqZHmNOgNRaNXirMS5nJmRHjxx1CSPJH951/6jBfoOhO7g+DTLJG4
         +qCQ==
X-Forwarded-Encrypted: i=1; AKwUvByX4Y6JklcNkd7BX9e4fTjvYIwSkLzfGo7XF89M8OFoFm0ZphsuECioXqrBC7L9T1N+jlw=@vger.kernel.org
X-Gm-Message-State: AFuF++n+PCf/UKc5XM/X55x5kVZuvOHwltoAokRGVIlUO1PW4XlEr14T
	gq/A0dkQGK/JBswP00xHOK8oEHDDCkbDoGB+cJMDOjgDm9YsQqJrBtu1Net87RKtvA==
X-Gm-Gg: AYBFou3hHPR8avtcLh94EK0RbVLigJNR7miQ2EvvYcWOW9J2hZJNKSEga4oVF0AKHl+
	UD9E2vx5dpV3+RanZFSqiDkytOvtmiwhMUOKnLkKZ1ofgMm4nBSH0IR5JWImA5o5+GX+SSa03mL
	8zFJoKJXv5904eQVeowtDoI7Z3QYhEBHcfb7P0xe4LO7W2M9IWt0AZ5a5Jgnd1hEKqi8N4YpPP8
	c/4wk0fFlnP5wFPQ46yIPtlv7DLelHhgNdCDg9kxXv7Gl2IaaxlWCS067QyGB7PA9DxKcR+Hn86
	HanxioAM5TAmp1uAf+mPpL6Y4go2EydrUn7WLryD7hg0hbRBXZLrAmIfrTkuwBH464eBcnIqvQM
	KoR7YPi832I4nYVc2WV8DRqeNPcxzqcJsYH3wpCL3ZmqkqmDsM41qXYEaXKRyrwJ3L7a0/HLmRY
	oBuZOxEf8XiNdPNeNoz86edMlU6kgYQdAjJ+CrdEGyc3/cqo1wRiXMJUrH9UC+z6uAkHjOnXKSZ
	BImOZRb0MpdjLBcVO4vBhWJZ7YOl5G6IA00+Mty
X-Received: by 2002:a17:90b:384b:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-39b261e79f1mr53396746a91.13.1788990058864;
        Wed, 09 Sep 2026 14:40:58 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e840f3asm78161a91.12.2026.09.09.14.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:40:57 -0700 (PDT)
Date: Wed, 9 Sep 2026 21:40:53 +0000
From: David Matlack <dmatlack@google.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/4] selftests/vfio: Wait out transient -EBUSY on
 open/bind
Message-ID: <aqHSZY2IhWfK-jhl@google.com>
References: <20260901215358.2421359-1-alex.williamson@nvidia.com>
 <20260901215358.2421359-3-alex.williamson@nvidia.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901215358.2421359-3-alex.williamson@nvidia.com>

On 2026-09-01 03:53 PM, Alex Williamson wrote:
> If a test is killed, for example due to timeout, fput can be delayed,
> allowing the subsequent test to be started while the failing test still
> holds the device open count elevated.  This results in a cascade of
> failures as each subsequent test fails on open, blocked by the single
> user requirement at the group or device cdev file.
> 
> We can make the test framework more robust, and allow better
> identification of specific failing scenarios, by waiting-out transient
> -EBUSY failures on group open and cdev bind.
> 
> The 20s retry window is heuristically determined in testing on a system
> where scheduling can be significantly delayed due to SMI handling of
> platform errors generated from the mix-and-match test.
> 
> The SR-IOV uAPI and IOMMUFD setup tests retain their non-retry bind
> paths as these are not expected to encounter process kills due to
> underlying platform error handling variability.
> 
> Assisted-by: Qwen3.8-27B
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

I think we should fix this in kselftest_harness.h instead.

If the poll() times out the harness issues SIGKILL but then does not
wait for the process to finish exiting (waitpid(..., WNOHANG). If we
drop WNOHANG then the harness will wait for the killed process to exit
before proceeding with the next test case.

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 1e459619fe86..150bd690ca7b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1008,7 +1008,7 @@ static void __wait_for_test(struct __test_metadata *t)
         /* signal process group */
         kill(-(t->pid), SIGKILL);
     }
-    child = waitpid(t->pid, &status, WNOHANG);
+    child = waitpid(t->pid, &status, 0);
     if (child == -1 && errno != EINTR) {
         t->exit_code = KSFT_FAIL;
         fprintf(TH_LOG_STREAM,

